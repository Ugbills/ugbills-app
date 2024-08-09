import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:zeelpay/constants/api/enpoints.dart';
import 'package:zeelpay/helpers/api/response_helper.dart';
import 'package:zeelpay/helpers/snacks/snacks_helper.dart';
import 'package:zeelpay/helpers/storage/token.dart';
import 'package:zeelpay/helpers/storage/user.dart';
import 'package:zeelpay/providers/state/loading_state_provider.dart';
import 'package:zeelpay/screens/account_screen.dart';
import 'package:zeelpay/screens/user/more/security/password.dart';
import 'package:zeelpay/screens/user/user.dart';

class AuthRepository {
  final ApiRepository api = ApiRepository();

  ///This function handles login
  Future<void> login(
    String email,
    String password,
    WidgetRef ref,
    BuildContext context,
  ) async {
    await api.handleRequest(
        endpoint: Endpoints.passwordLogin,
        requestType: RequestType.post,
        data: {
          'email': email,
          'password': password,
          "device_name": "string",
          "device_id": "string",
          "operating_system": "string",
          "latitude": "string",
          "longitude": "string"
        },
        loadingProvider: isLoadingProvider,
        ref: ref,
        onSuccess: (data) async {
          await UserStorage().update(data["data"]["user_id"]);
          await TokenStorage().storeToken(data["data"]["access_key"]);
          if (context.mounted) {
            await successSnack(context, data["message"]);
          }
          Go.toRemoveAll(const UserScreen());
        },
        onError: (message) async {
          await errorSnack(context, message);
          log(message);
        });
  }

  ///this function handles logout
  Future<void> logout() async {
    await TokenStorage().deleteToken();
    UserStorage().update("");
    Go.toRemoveAll(const AccountScreen());
  }

  ///This function handles forgot password
  Future<void> forgotPassword(
      String email, WidgetRef ref, BuildContext context) async {
    await api.handleRequest(
        requestType: RequestType.post,
        endpoint: Endpoints.recoverPassword,
        data: {
          'email': email,
        },
        loadingProvider: isLoadingProvider,
        ref: ref,
        onSuccess: (data) async {
          await successSnack(context, data["message"]);
          Go.to(const ChangePassword());
        },
        onError: (message) async {
          await errorSnack(context, message);
          log(message);
        });
  }

  //
}
