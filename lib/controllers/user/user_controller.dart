// ignore_for_file: avoid_build_context_in_providers, avoid_manual_providers_as_generated_provider_dependency
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/constants/api/endpoints.dart';
import 'package:ugbills/controllers/auth/auth_helper.dart';
import 'package:ugbills/helpers/api/response_helper.dart';
import 'package:ugbills/helpers/snacks/snacks_helper.dart';
import 'package:ugbills/providers/state/loading_state_provider.dart';
import 'package:ugbills/screens/user/more/account_level/congrats.dart';
import 'package:ugbills/screens/user/more/account_level/tier-3/kyc_model.dart';
import 'package:ugbills/screens/user/more/security/otp.dart';
import 'package:ugbills/screens/user/more/success.dart';

part 'user_controller.g.dart';

final ApiRepository api = ApiRepository();

@riverpod
class UserController extends _$UserController {
  @override
  dynamic build() {
    throw UnimplementedError();
  }

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
        onSuccess: (data) async {
          ref.read(isLoadingProvider.notifier).state = false;
          Go.toRemoveAll(const Success(
            title: "Done",
            body:
                "Your account statement has been successfully generated and sent to your email. Check your inbox for the details.",
            button: "Done",
          ));
        },
        onError: (message) async {
          ref.read(isLoadingProvider.notifier).state = false;
          errorSnack(context, message);
          log(message);
        });
  }

  ///function to update user profile picture
  Future<void> updateProfilePicture(
      {required File image, required BuildContext context}) async {
    await api.handleRequest(
        endpoint: Endpoints.profileImage,
        auth: true,
        requestType: RequestType.upload,
        file: image,
        key: 'file',
        onSuccess: (data) async {
          successSnack(context, "Profile picture updated successfully");
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
        onSuccess: (data) async {
          await refreshUser(ref: ref);
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

  /// function to update user password
  Future<void> updatePassword(
      {required String currentPassword,
      required WidgetRef ref,
      required String newPassword,
      required BuildContext context}) async {
    await api.handleRequest(
        endpoint: Endpoints.changePassword,
        auth: true,
        requestType: RequestType.post,
        data: {
          'old_password': currentPassword,
          'new_password': newPassword,
        },
        onSuccess: (data) async {
          await refreshUser(ref: ref);
          Go.to(const Success(
            title: "Updated",
            body:
                "Your password has been updated successfully and should be used on next login.",
          ));
        },
        onError: (message) async {
          await errorSnack(context, message);
          log(message);
        });
  }

  /// send reset otp
  Future<void> sendResetOTP(
      {required String email,
      required BuildContext context,
      required WidgetRef ref}) async {
    await api.handleRequest(
        endpoint: Endpoints.recoverPassword,
        auth: false,
        requestType: RequestType.post,
        data: {
          'email': email,
        },
        onSuccess: (data) async {
          ref.read(isLoadingProvider.notifier).state = false;
          Go.to(OPTScreen());
        },
        onError: (message) async {
          ref.read(isLoadingProvider.notifier).state = false;
          await errorSnack(context, message);
          log(message);
        });
  }

  /// function to reset user pin
  Future<void> resetPin(
      {required String otp,
      required String email,
      required String newPin,
      required BuildContext context,
      required WidgetRef ref}) async {
    await api.handleRequest(
        endpoint: Endpoints.resetPin,
        auth: false,
        requestType: RequestType.post,
        data: {
          'code': otp,
          'new_pin': newPin,
          'email': email,
        },
        onSuccess: (data) async {
          await refreshUser(ref: ref);
          ref.read(isLoadingProvider.notifier).state = false;
          Go.to(const Success(
            title: "Updated",
            body: "Your transaction pin has been updated successfully.",
          ));
        },
        onError: (message) async {
          ref.read(isLoadingProvider.notifier).state = false;
          await errorSnack(context, message);
          log(message);
        });
  }

  /// function to reset user pin
  Future<void> setPin(
      {required String newPin,
      required BuildContext context,
      required WidgetRef ref}) async {
    await api.handleRequest(
        endpoint: Endpoints.userSetPin,
        auth: true,
        requestType: RequestType.post,
        data: {
          'pin': newPin,
        },
        onSuccess: (data) async {
          await refreshUser(ref: ref);
          ref.read(isLoadingProvider.notifier).state = false;
          Go.to(const Success(
            title: "Updated",
            body: "Your transaction pin has been updated successfully.",
          ));
        },
        onError: (message) async {
          ref.read(isLoadingProvider.notifier).state = false;
          await errorSnack(context, message);
          log(message);
        });
  }

  Future<void> submitBVN(
      {required String dob,
      required String bvn,
      required BuildContext context,
      required WidgetRef ref}) async {
    await api.handleRequest(
        endpoint: Endpoints.bvnUpdate,
        auth: true,
        requestType: RequestType.post,
        data: {
          'bvn': bvn,
          'date_of_birth': dob,
        },
        onSuccess: (data) async {
          await refreshUser(ref: ref);
          ref.read(isLoadingProvider.notifier).state = false;
          Go.to(const Congrats());
        },
        onError: (message) async {
          ref.read(isLoadingProvider.notifier).state = false;
          await errorSnack(context, message);
          log(message);
        });
  }

  Future<void> submitAddress(
      {required AddressData address,
      required String frontImage,
      required String backImage,
      required String selfie,
      required String documentType,
      required String documentNumber,
      required BuildContext context,
      required WidgetRef ref}) async {
    await api.handleRequest(
        endpoint: Endpoints.addressUpdate,
        auth: false,
        requestType: RequestType.post,
        data: {
          'document_type': documentType,
          'document_number': documentNumber,
          'front_url': frontImage,
          'bill_url': "",
          'back_url': backImage,
          'face_url': selfie,
          'address': address.houseAddress,
          'city': address.city,
          'state': address.state,
          'postal_code': address.postalCode,
        },
        onSuccess: (data) async {
          await refreshUser(ref: ref);
          ref.read(isLoadingProvider.notifier).state = false;
          Go.to(const Congrats());
        },
        onError: (message) async {
          ref.read(isLoadingProvider.notifier).state = false;
          await errorSnack(context, message);
          log(message);
        });
  }
}
