import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:zeelpay/constants/api/enpoints.dart';
import 'package:zeelpay/helpers/api/response_helper.dart';
import 'package:zeelpay/providers/state/loading_state_provider.dart';
import 'package:zeelpay/screens/auth/reset/link_sent_screen.dart';
import 'package:zeelpay/screens/user/more/security/password.dart';

class AuthRepository {
  final ApiRepository api = ApiRepository();

///This function handles login
  Future<void> login(String email, String password, WidgetRef ref) async {
    await api.handleRequest(
        endpoint: Endpoints.login,
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
        onSuccess: (data) {
          log(data);
          Go.to(const LinkSentScreen());
        },
        onError: (message) {
          log(message);
        });
  }

///This function handles forgot password
  Future<void> forgotPassword(String email, WidgetRef ref) async {
    await api.handleRequest(
        requestType: RequestType.post,
        endpoint: Endpoints.recoverPassword,
        data: {
          'email': email,
        },
        loadingProvider: isLoadingProvider,
        ref: ref,
        onSuccess: (data) {
          Go.to(const ChangePassword());
        },
        onError: (message) {
          log(message);
        });
  }
}
