import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zeelpay/constants/api/endpoints.dart';
import 'package:zeelpay/helpers/api/response_helper.dart';
import 'package:zeelpay/helpers/storage/token.dart';
import 'package:zeelpay/models/api/card_transaction_mode.dart';
import 'package:zeelpay/models/api/card_type_model.dart';
import 'package:zeelpay/models/api/cards_model.dart';
import 'package:zeelpay/models/api/virtual_card_model.dart';
import 'package:zeelpay/services/http_service.dart';

part 'card_provider.g.dart';

ApiRepository api = ApiRepository();

var tokenStorage = TokenStorage();

var httpService = HttpService();

@Riverpod(keepAlive: true)
Future<bool?> canCreateCard(Ref ref) async {
  try {
    var token = await tokenStorage.getToken();
    var response = await httpService.getRequest(Endpoints.cardStatus,
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
        responseType: ResponseType.plain);

    if (response.statusCode == 200) {
      log(response.data);

      var data = jsonDecode(response.data);

      return data["success"] as bool;
    }
  } on DioException catch (e) {
    if (e.response!.statusCode == 404) {
      return false;
    }

    throw Exception(e);
  }
  return null;
}

@Riverpod(keepAlive: false)
Future<CardsModel?> getAllCards(Ref ref) async {
  try {
    var token = await tokenStorage.getToken();
    var response = await httpService.getRequest(Endpoints.cardList,
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
        responseType: ResponseType.plain);

    if (response.statusCode == 200) {
      log(response.data);

      var data = jsonDecode(response.data);

      return CardsModel.fromJson(data);
    }
  } on DioException catch (e) {
    throw Exception(e);
  }
  return null;
}

@Riverpod(keepAlive: false)
Future<VirtualCardModel?> getCard(Ref ref,
    {required String cardId}) async {
  try {
    var token = await tokenStorage.getToken();
    var response = await httpService.getRequest(Endpoints.cardDetails,
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
        queryParameters: {"card_id": cardId},
        responseType: ResponseType.plain);

    if (response.statusCode == 200) {
      log(response.data);

      var data = jsonDecode(response.data);

      return VirtualCardModel.fromJson(data);
    }
  } on DioException catch (e) {
    throw Exception(e);
  }
  return null;
}

@Riverpod(keepAlive: false)
Future<CardTransactionModel?> getCardTransactions(Ref ref,
    {required String cardId}) async {
  try {
    var token = await tokenStorage.getToken();
    var response = await httpService.getRequest(Endpoints.cardTransactions,
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
        queryParameters: {"card_id": cardId},
        responseType: ResponseType.plain);

    if (response.statusCode == 200) {
      log(response.data);

      var data = jsonDecode(response.data);

      return CardTransactionModel.fromJson(data);
    }
  } on DioException catch (e) {
    throw Exception(e);
  }
  return null;
}

@Riverpod(keepAlive: false)
Future<CardTypeModel?> getCardTypes(Ref ref) async {
  try {
    var token = await tokenStorage.getToken();
    var response = await httpService.getRequest(Endpoints.cardTypes,
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
        responseType: ResponseType.plain);

    if (response.statusCode == 200) {
      log(response.data);

      var data = jsonDecode(response.data);

      return CardTypeModel.fromJson(data);
    }
  } on DioException catch (e) {
    throw Exception(e);
  }
  return null;
}
