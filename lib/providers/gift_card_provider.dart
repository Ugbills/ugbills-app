import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zeelpay/constants/api/endpoints.dart';
import 'package:zeelpay/helpers/api/response_helper.dart';
import 'package:zeelpay/helpers/storage/token.dart';
import 'package:zeelpay/models/api/gift_card_country_model.dart';
import 'package:zeelpay/services/http_service.dart';

part 'gift_card_provider.g.dart';

ApiRepository api = ApiRepository();

var tokenStorage = TokenStorage();

var httpService = HttpService();

@Riverpod(keepAlive: true)
Future<GiftCardCountryModel?> giftCardCountries(
    GiftCardCountriesRef ref) async {
  try {
    var token = await tokenStorage.getToken();
    var response = await httpService.getRequest(Endpoints.giftCardCountries,
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
        responseType: ResponseType.plain);

    if (response.statusCode == 200) {
      log(response.data);

      var data = jsonDecode(response.data);

      var supported = GiftCardCountryModel.fromJson(data);
      return supported;
    }
  } on DioException catch (e) {
    throw Exception(e);
  }
  return null;
}

@Riverpod(keepAlive: false)
Future<dynamic> giftCards(GiftCardsRef ref,
    {required String countryCode, int limit = 100, int page = 1}) async {
  try {
    var token = await tokenStorage.getToken();
    var response = await httpService.getRequest(Endpoints.giftCardBrands,
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
        queryParameters: {
          'country_code': countryCode,
          'size': limit,
          'page': page
        },
        responseType: ResponseType.plain);

    if (response.statusCode == 200) {
      log(response.data);

      var data = jsonDecode(response.data);

      return data;
    }
  } on DioException catch (e) {
    throw Exception(e);
  }
  return null;
}
