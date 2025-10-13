import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/constants/api/mobile_endpoints.dart';
import 'package:ugbills/helpers/api/response_helper.dart';
import 'package:ugbills/helpers/snacks/snacks_helper.dart';
import 'package:ugbills/helpers/storage/token.dart';
import 'package:ugbills/helpers/storage/user.dart';
import 'package:ugbills/providers/state/loading_state_provider.dart';
import 'package:ugbills/providers/transaction_provider.dart';
import 'package:ugbills/providers/user_provider.dart';
import 'package:ugbills/screens/account_screen.dart';
import 'package:ugbills/screens/auth/create/account_created.dart';
import 'package:ugbills/screens/auth/create/set_pin.dart';
import 'package:ugbills/screens/auth/reset/link_sent_screen.dart';
import 'package:ugbills/screens/user/user.dart';
import 'package:ugbills/services/http_service.dart';

class AuthRepository {
  final ApiRepository api = ApiRepository();
  final httpService = HttpService();

  ///This function handles login
  Future<String> login(String email, String password, WidgetRef ref,
      BuildContext context) async {
    try {
      //get devices notification token
      // var token = await FirebaseMessaging.instance.getToken();
      // log(token.toString());

      var message = "";
      await api.handleRequest(
          endpoint: MobileEndpoints.login,
          requestType: RequestType.post,
          data: {'email': email.trim(), 'password': password},
          onSuccess: (data) async {
            var json = jsonDecode(data);
            log(json.toString());
            if (json["success"] == true) {
              message = json["message"];
              await TokenStorage().storeToken(json["data"]["access_key"]);
              await UserStorage().update(json["data"]["user_id"].toString());
              await UserStorage().updateEmail(email.trim());
              // ref.invalidate(fetchUserInformationProvider);
              // ref.invalidate(fetchUserTransactionsProvider());
              // saveNotificationToken();
              await successSnack(context, message);
              Go.toRemoveAll(const UserScreen());
            } else {
              log(json.toString());
              message = json["message"] ?? "Login failed";
              errorSnack(context, message);
            }
          },
          onError: (getmessage) async {
            errorSnack(context, getmessage);
            message = getmessage;
            log(message);
          });
      return message;
    } catch (e) {
      log("something went wrong");
      log(e.toString());
      throw Exception(e);
    }
  }

  Future<String> saveNotificationToken() async {
    try {
      //get devices notification token
      var token = await FirebaseMessaging.instance.getToken();
      log(token.toString());
      var message = "";
      await api.handleRequest(
          auth: true,
          endpoint: Endpoints.userNotificationToken,
          requestType: RequestType.post,
          data: {
            'token': token,
          },
          onSuccess: (data) async {
            var json = jsonDecode(data);
            message = json["message"];
            log(message);
          },
          onError: (getmessage) async {
            message = getmessage;
            log(message);
          });
      return message;
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
  }

  ///this function handles logout
  Future<void> logout() async {
    await TokenStorage().deleteToken();
    UserStorage().update("");
    UserStorage().updateEmail("");
    UserStorage().updateBiometrics(false);
    UserStorage().updatePin("");
    Go.toRemoveAll(const AccountScreen());
  }

  Future forgotPassword(
      {required BuildContext context,
      required String email,
      required WidgetRef ref}) async {
    try {
      ref.read(isLoadingProvider.notifier).state = true;
      var response =
          await httpService.postRequest(Endpoints.recoverPassword, headers: {
        'Y-decryption-key': '1234'
      }, data: {
        'email': email.trim(),
      });

      ref.read(isLoadingProvider.notifier).state = false;

      if (response.statusCode == 200) {
        var data = jsonDecode(response.data);
        log(data.toString());
        Go.to(LinkSentScreen(
          email: email,
        ));
      }
    } on DioException catch (e) {
      log(e.toString());
      ref.read(isLoadingProvider.notifier).state = false;
      if (e.response!.data != null) {
        var data = jsonDecode(e.response!.data);
        log(data["message"]);
        errorSnack(context, data["message"]);
      }
      throw Exception(e);
    }
  }

  Future resetPassword(
      {required BuildContext context,
      required String email,
      required String password,
      required String code,
      required WidgetRef ref}) async {
    try {
      ref.read(isLoadingProvider.notifier).state = true;
      var response = await httpService.postRequest(Endpoints.resetPassword,
          headers: {
            'Y-decryption-key': '1234'
          },
          data: {
            'email': email.trim(),
            "new_password": password,
            "code": code
          });

      ref.read(isLoadingProvider.notifier).state = false;

      if (response.statusCode == 200) {
        var data = jsonDecode(response.data);
        log(data.toString());
        Go.to(const SetransactionPin());
      }
    } on DioException catch (e) {
      log(e.toString());
      ref.read(isLoadingProvider.notifier).state = false;
      if (e.response!.data != null) {
        var data = jsonDecode(e.response!.data);
        log(data["message"]);
        errorSnack(context, data["message"]);
      }
      throw Exception(e);
    }
  }

  Future signUp(
      {required BuildContext context,
      required String email,
      required String password,
      required String fullName,
      required String phoneNumber,
      required String userName,
      required String referralCode,
      required WidgetRef ref}) async {
    try {
      ref.read(isLoadingProvider.notifier).state = true;
      var response =
          await httpService.postRequest(MobileEndpoints.register, headers: {
        'Content-Type': 'application/json'
      }, data: {
        "email": email.trim(),
        "password1": password,
        "fullname": fullName,
        "phone": phoneNumber,
        "username": userName,
        "refname": referralCode,
        "password2": password
      });

      ref.read(isLoadingProvider.notifier).state = false;

      if (response.statusCode == 201 || response.statusCode == 200) {
        var data = jsonDecode(response.data);
        log(data.toString());
        Go.to(const AccountCreatedScreen());
      }
    } on DioException catch (e) {
      log(e.toString());
      ref.read(isLoadingProvider.notifier).state = false;
      if (e.response!.data != null) {
        var data = jsonDecode(e.response!.data);
        log(data["message"]);
        // ignore: use_build_context_synchronously
        errorSnack(context, data["message"]);
      }
      throw Exception(e);
    }
  }

  Future verifyEmail(
      {required BuildContext context,
      required String email,
      required String code,
      required WidgetRef ref}) async {
    try {
      ref.read(isLoadingProvider.notifier).state = true;
      var response = await httpService.postRequest(Endpoints.verifyEmail,
          headers: {'Y-decryption-key': '1234'},
          data: {"code": code, "email": email.trim()});
      ref.read(isLoadingProvider.notifier).state = false;
      if (response.statusCode == 200) {
        var data = jsonDecode(response.data);
        log(data.toString());
        await TokenStorage().storeToken(data["data"]["access_key"]);
        await UserStorage().update(data["data"]["user_id"]);
        Go.to(const AccountCreatedScreen());
      }
    } on DioException catch (e) {
      log(e.toString());
      ref.read(isLoadingProvider.notifier).state = false;
      if (e.response!.data != null) {
        var data = jsonDecode(e.response!.data);
        log(data["message"]);
        errorSnack(context, data["message"]);
      }
      throw Exception(e);
    }
  }

  Future resendVerifyEmail(
      {required BuildContext context,
      required String email,
      required WidgetRef ref}) async {
    try {
      ref.read(isLoadingProvider.notifier).state = true;
      var response = await httpService.getRequest(Endpoints.resendEmailVerify,
          headers: {'Y-decryption-key': '1234'},
          queryParameters: {"email": email.trim()});

      ref.read(isLoadingProvider.notifier).state = false;

      if (response.statusCode == 200) {
        successSnack(context, response.data["message"]);
      }
    } on DioException catch (e) {
      log(e.toString());
      ref.read(isLoadingProvider.notifier).state = false;
      if (e.response!.data != null) {
        var data = jsonDecode(e.response!.data);
        log(data["message"]);
        errorSnack(context, data["message"]);
      }
      throw Exception(e);
    }
  }

  //

  Future loginWithPin(
      {required BuildContext context,
      required String pin,
      required WidgetRef ref}) async {
    try {
      ref.read(isLoadingProvider.notifier).state = true;

      var message = "";
      await api.handleRequest(
          endpoint: MobileEndpoints.pinLogin,
          requestType: RequestType.post,
          data: {'pin': pin, 'user_id': UserStorage().get()},
          onSuccess: (data) async {
            var json = jsonDecode(data);
            log(json.toString());
            if (json["success"] == true) {
              message = json["message"];
              await TokenStorage().storeToken(json["data"]["access_key"]);
              await UserStorage().update(json["data"]["user_id"].toString());
              await UserStorage().updatePin(pin);
              ref.invalidate(fetchMobileUserInformationProvider);
              ref.invalidate(fetchUserTransactionsProvider());
              await successSnack(context, message);
              Go.toRemoveAll(const UserScreen());
            } else {
              log(json.toString());
              message = json["message"] ?? "PIN login failed";
              errorSnack(context, message);
            }
          },
          onError: (getmessage) async {
            errorSnack(context, getmessage);
            message = getmessage;
            log(message);
          });

      ref.read(isLoadingProvider.notifier).state = false;
    } catch (e) {
      log("PIN login went wrong");
      log(e.toString());
      ref.read(isLoadingProvider.notifier).state = false;
      throw Exception(e);
    }
  }

  //delete account and it only takes pin as parameter

  Future deleteAccount(
      {required BuildContext context,
      required String pin,
      required WidgetRef ref}) async {
    try {
      ref.read(isLoadingProvider.notifier).state = true;
      var token = await TokenStorage().getToken();
      var response = await httpService.postRequest(Endpoints.userDelete,
          headers: {
            'X-Forwarded-For': '1234',
            'Y-decryption-key': '1234',
            "ZEEL-SECURE-KEY": token
          },
          data: {
            "pin": pin
          });
      ref.read(isLoadingProvider.notifier).state = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.data);
        log(data.toString());
        logout();
      }
    } on DioException catch (e) {
      log(e.toString());
      ref.read(isLoadingProvider.notifier).state = false;
      if (e.response!.data != null) {
        var data = jsonDecode(e.response!.data);
        log(data["message"]);
        errorSnack(context, data["message"]);
      }
      throw Exception(e);
    }
  }
}
