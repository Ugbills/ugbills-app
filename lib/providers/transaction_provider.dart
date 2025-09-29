import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ugbills/constants/api/endpoints.dart';
import 'package:ugbills/helpers/api/response_helper.dart';
import 'package:ugbills/helpers/storage/token.dart';
import 'package:ugbills/models/api/transactions_model.dart';
import 'package:ugbills/services/http_service.dart';

part 'transaction_provider.g.dart';

ApiRepository api = ApiRepository();

var tokenStorage = TokenStorage();

var httpService = HttpService();

@Riverpod(keepAlive: false)
Future<List<Transaction>?> fetchUserTransactions(
  FetchUserTransactionsRef ref, {
  int? page = 1,
  int? limit = 10,
}) async {
  try {
    var token = await tokenStorage.getToken();
    log(token!);
    var response = await httpService.getRequest(
        "${Endpoints.userTransactions}?page=$page&size=$limit",
        headers: {"ZEEL-SECURE-KEY": token},
        responseType: ResponseType.plain);
    if (response.statusCode == 200) {
      log(response.data);
      var data = jsonDecode(response.data);

      var transactions = TransactionsModel.fromJson(data);
      return transactions.transactions;
    }
  } on DioException catch (e) {
    throw Exception(e);
  }
  return null;
}
