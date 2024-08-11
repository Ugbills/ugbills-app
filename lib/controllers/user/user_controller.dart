import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:zeelpay/constants/api/enpoints.dart';
import 'package:zeelpay/helpers/api/response_helper.dart';
import 'package:zeelpay/helpers/snacks/snacks_helper.dart';
import 'package:zeelpay/providers/state/loading_state_provider.dart';
import 'package:zeelpay/providers/user_provider.dart';
import 'package:zeelpay/screens/user/more/success.dart';

class UserController {
  final ApiRepository api = ApiRepository();

  /// function to generate account statement

  Future<void> generateStatement(
      {required String startDate,
      required String endDate,
      required String format,
      required WidgetRef ref,
      required BuildContext context}) async {
    await api.handleRequest(
        endpoint: Endpoints.accountStatement,
        auth: true,
        requestType: RequestType.post,
        data: {
          'start_date': startDate,
          'end_date': endDate,
          "statement_format": format,
        },
        loadingProvider: isLoadingProvider,
        ref: ref,
        onSuccess: (data) async {
          if (context.mounted) {
            await successSnack(context, data["message"]);
          }
          Go.toRemoveAll(const Success(
            title: "Done",
            body:
                "Your account statement has been successfully generated and sent to your email. Check your inbox for the details.",
            button: "Done",
          ));
        },
        onError: (message) async {
          await errorSnack(context, message);
          log(message);
        });
  }

  ///function to update user profile picture
  Future<void> updateProfilePicture(
      {required File image,
      required WidgetRef ref,
      required BuildContext context}) async {
    await api.handleRequest(
        endpoint: Endpoints.profileImage,
        auth: true,
        requestType: RequestType.upload,
        file: image,
        key: 'file',
        loadingProvider: isLoadingProvider,
        ref: ref,
        onSuccess: (data) async {
          // ignore: unused_result
          ref.refresh(fetchUserInformationProvider);
          if (context.mounted) {
            await successSnack(context, data["message"]);
          }
        },
        onError: (message) async {
          await errorSnack(context, message);
          log(message);
        });
  }

  //// function to update user profile
  Future<void> updateProfile(
      {required String phoneNumber,
      required String userName,
      required WidgetRef ref,
      required BuildContext context}) async {
    await api.handleRequest(
        endpoint: "${Endpoints.user}/",
        auth: true,
        requestType: RequestType.post,
        data: {
          'phone_number': phoneNumber,
          'username': userName,
        },
        loadingProvider: isLoadingProvider,
        ref: ref,
        onSuccess: (data) async {
          // ignore: unused_result
          ref.refresh(fetchUserInformationProvider);
          if (context.mounted) {
            await successSnack(context, data["message"]);
          }
          Go.to(const Success(
            title: "Updated",
            body:
                "Your profile has been successfully updated. Click the button below to go back.",
            button: "Back",
          ));
        },
        onError: (message) async {
          await errorSnack(context, message);
          log(message);
        });
  }
}
