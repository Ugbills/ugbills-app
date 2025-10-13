import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ugbills/constants/api/mobile_endpoints.dart';
import 'package:ugbills/helpers/storage/token.dart';
import 'package:ugbills/models/api/internet_data_model.dart';
import 'package:ugbills/services/http_service.dart';

part 'internet_data_provider.g.dart';

var tokenStorage = TokenStorage();
var httpService = HttpService();

@Riverpod(keepAlive: false)
Future<List<InternetDataProduct>?> fetchInternetData(
  FetchInternetDataRef ref,
) async {
  try {
    var token = await tokenStorage.getToken();
    log('Token: $token');

    var response = await httpService.getRequest(
      MobileEndpoints.internet,
      headers: {"ZEEL-SECURE-KEY": token!},
      responseType: ResponseType.plain,
    );

    if (response.statusCode == 200) {
      log('Internet Data Response: ${response.data}');
      var data = jsonDecode(response.data);

      var internetDataResponse = InternetDataResponse.fromJson(data);
      return internetDataResponse.products;
    }
  } on DioException catch (e) {
    log('Error fetching internet data: $e');
    throw Exception('Failed to fetch internet data: ${e.message}');
  }
  return null;
}