import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zeelpay/constants/api/endpoints.dart';
import 'package:zeelpay/helpers/api/response_helper.dart';
import 'package:zeelpay/helpers/storage/token.dart';
import 'package:zeelpay/models/api/electricity_model.dart';
import 'package:zeelpay/services/http_service.dart';

part 'electricity_provider.g.dart';

ApiRepository api = ApiRepository();

var tokenStorage = TokenStorage();

var httpService = HttpService();

@Riverpod(keepAlive: true)
Future<ElectricityModel?> fetchElectricityProvider(
    FetchElectricityProviderRef ref) async {
  try {
    var token = await tokenStorage.getToken();
    var response = await httpService.getRequest(Endpoints.electricityProviders,
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
        responseType: ResponseType.plain);

    if (response.statusCode == 200) {
      log(response.data);

      var data = jsonDecode(response.data);

      var providers = ElectricityModel.fromJson(data);
      return providers;
    }
  } on DioException catch (e) {
    throw Exception(e);
  }
  return null;
}
