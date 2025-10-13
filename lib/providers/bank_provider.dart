import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ugbills/constants/api/mobile_endpoints.dart';
import 'package:ugbills/helpers/api/response_helper.dart';
import 'package:ugbills/helpers/storage/token.dart';
import 'package:ugbills/models/api/bank_model.dart';
import 'package:ugbills/services/http_service.dart';

part 'bank_provider.g.dart';

ApiRepository api = ApiRepository();

var tokenStorage = TokenStorage();

var httpService = HttpService();

@Riverpod(keepAlive: true)
Future<BankModel?> fetchBanks(FetchBanksRef ref) async {
  try {
    var token = await tokenStorage.getToken();

    log('Fetching banks with token: ${token?.substring(0, 10)}...');

    var response = await httpService.getRequest(
      MobileEndpoints.bankList,
      headers: {
        'X-Forwarded-For': '1234',
        'Y-decryption-key': '1234',
        "ZEEL-SECURE-KEY": token
      },
      responseType: ResponseType.plain,
    );

    if (response.statusCode == 200) {
      log('Banks response: ${response.data}');
      var bankList = jsonDecode(response.data) as List<dynamic>;
      return BankModel.fromJson(bankList);
    }
  } on DioException catch (e) {
    log('Error fetching banks: ${e.toString()}');
    throw Exception('Failed to fetch banks: ${e.message}');
  }
  return null;
}
