import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ugbills/constants/api/endpoints.dart';
import 'package:ugbills/helpers/api/response_helper.dart';
import 'package:ugbills/helpers/storage/token.dart';
import 'package:ugbills/models/api/swap_model.dart';
import 'package:ugbills/services/http_service.dart';

part 'swap_provider.g.dart';

ApiRepository api = ApiRepository();

var tokenStorage = TokenStorage();

var httpService = HttpService();

@Riverpod(keepAlive: false)
Future<SwapResultModel?> swapAirtime(Ref ref,
    {required String network,
    required dynamic amount,
    required String phoneNumber}) async {
  try {
    var token = await tokenStorage.getToken();
    var response = await httpService.postRequest(Endpoints.swapConfirm,
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
        data: {
          "network_id": network,
          "amount": amount,
          "phone": phoneNumber
        });

    if (response.statusCode == 200) {
      log(response.data);
      var data = jsonDecode(response.data);
      var result = SwapResultModel.fromJson(data);
      return result;
    }
  } on DioException catch (e) {
    throw Exception(e);
  }
  return null;
}
