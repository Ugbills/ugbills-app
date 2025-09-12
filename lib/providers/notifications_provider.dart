import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ugbills/constants/api/endpoints.dart';
import 'package:ugbills/helpers/api/response_helper.dart';
import 'package:ugbills/helpers/storage/token.dart';
import 'package:ugbills/models/api/notifications_model.dart';
import 'package:ugbills/services/http_service.dart';

part 'notifications_provider.g.dart';

ApiRepository api = ApiRepository();

var tokenStorage = TokenStorage();

var httpService = HttpService();

@Riverpod(keepAlive: false)
Future<NotificationsModel?> fetchUserNotifications(
    FetchUserNotificationsRef ref) async {
  try {
    var token = await tokenStorage.getToken();

    log(token!);

    var response = await httpService.getRequest(Endpoints.userNotifications,
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
        responseType: ResponseType.plain);

    if (response.statusCode == 200) {
      log(response.data);
      return NotificationsModel.fromJson(jsonDecode(response.data));
    }
  } on DioException catch (e) {
    throw Exception(e);
  }
  return null;
}
