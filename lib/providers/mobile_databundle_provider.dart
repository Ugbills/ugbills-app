import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ugbills/constants/api/mobile_endpoints.dart';
import 'package:ugbills/helpers/storage/token.dart';
import 'package:ugbills/services/http_service.dart';

part 'mobile_databundle_provider.g.dart';

var tokenStorage = TokenStorage();
var httpService = HttpService();

@Riverpod(keepAlive: false)
Future<Map<String, dynamic>?> purchaseMobileData(
  PurchaseMobileDataRef ref, {
  required String productCode,
  required String variationCode,
  required String beneficiary,
  required String pin,
}) async {
  try {
    var token = await tokenStorage.getToken();
    log('Purchasing data: Product: $productCode, Variation: $variationCode, Phone: $beneficiary');

    var response = await httpService.postRequest(
      MobileEndpoints.databundle,
      data: {
        'product_code': productCode,
        'variation_code': variationCode,
        'beneficiary': beneficiary,
        'pin': pin,
      },
      headers: {"ZEEL-SECURE-KEY": token},
    );

    if (response.statusCode == 200) {
      log('Mobile Data Purchase Response: ${response.data}');
      var data = jsonDecode(response.data);
      return data;
    } else {
      log('Failed to purchase mobile data: ${response.statusCode}');
      return null;
    }
  } on DioException catch (e) {
    log('Error purchasing mobile data: $e');
    return null;
  }
}
