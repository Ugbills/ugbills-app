import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ugbills/constants/api/endpoints.dart';
import 'package:ugbills/helpers/api/response_helper.dart';
import 'package:ugbills/helpers/storage/token.dart';
import 'package:ugbills/models/api/crypto_buy_quote_model.dart';
import 'package:ugbills/models/api/crypto_model.dart';
import 'package:ugbills/models/api/crypto_sell_quote_model.dart';
import 'package:ugbills/services/http_service.dart';

part 'crypto_provider.g.dart';

ApiRepository api = ApiRepository();

var tokenStorage = TokenStorage();

var httpService = HttpService();

@Riverpod(keepAlive: true)
Future<CryptoListModel?> fetchCoinList(Ref ref) async {
  try {
    var token = await tokenStorage.getToken();
    var response = await httpService.getRequest(Endpoints.cryptoList,
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
        responseType: ResponseType.plain);

    if (response.statusCode == 200) {
      log(response.data);

      var data = jsonDecode(response.data);

      var supported = CryptoListModel.fromJson(data);
      return supported;
    }
  } on DioException catch (e) {
    throw Exception(e);
  }
  return null;
}

@Riverpod(keepAlive: false)
Future<CryptoBuyQuoteModel?> fetchCryptoBuyQuote(Ref ref,
    {required String currency, required double amount}) async {
  try {
    var token = await tokenStorage.getToken();
    var response = await httpService.getRequest(
        "${Endpoints.cryptoBuyQuote}$currency&amount=$amount",
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
        responseType: ResponseType.plain);

    if (response.statusCode == 200) {
      log(response.data);

      var data = jsonDecode(response.data);

      var supported = CryptoBuyQuoteModel.fromJson(data);
      return supported;
    }
  } on DioException catch (e) {
    throw Exception(e);
  }
  return null;
}

@Riverpod(keepAlive: false)
Future<CryptoSellQuoteModel?> fetchCryptoSellQuote(Ref ref,
    {required String currency,
    required String network,
    required double amount}) async {
  try {
    var token = await tokenStorage.getToken();
    var response = await httpService.postRequest(Endpoints.cryptoSell,
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
        data: {
          "currency": currency,
          "network": network,
          "volume": amount
        });

    if (response.statusCode == 200) {
      log(response.data);

      var data = jsonDecode(response.data);

      var supported = CryptoSellQuoteModel.fromJson(data);
      return supported;
    }
  } on DioException catch (e) {
    if (e.response!.data != null) {
      throw Exception(e.response!.data["message"].toString());
    }
    throw Exception(e);
  }
  return null;
}
