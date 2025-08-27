import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zeelpay/constants/api/endpoints.dart';
import 'package:zeelpay/helpers/api/response_helper.dart';
import 'package:zeelpay/helpers/storage/token.dart';
import 'package:zeelpay/models/api/transactions_model.dart';
import 'package:zeelpay/services/http_service.dart';

part 'transaction_provider.g.dart';

ApiRepository api = ApiRepository();

var tokenStorage = TokenStorage();

var httpService = HttpService();

@Riverpod(keepAlive: false)
Future<List<ResponseData>?> fetchUserTransactions(
  FetchUserTransactionsRef ref, {
  int? page = 1,
  int? limit = 10,
}) async {
  try {
    var token = await tokenStorage.getToken();
    log(token!);
    var response = await httpService.getRequest(
        "${Endpoints.userTransactions}?page=$page&size=$limit",
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
        responseType: ResponseType.plain);
    if (response.statusCode == 200) {
      log(response.data);
      var data = jsonDecode(response.data);

      var transactions = TransactionsModel.fromJson(data);
      return transactions.data!.responseData;
    }
  } on DioException catch (e) {
    throw Exception(e);
  }
  return null;
}
