import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ugbills/constants/api/mobile_endpoints.dart';
import 'package:ugbills/helpers/storage/token.dart';
import 'package:ugbills/models/api/mobile_airtime_model.dart';
import 'package:ugbills/services/http_service.dart';

part 'mobile_airtime_provider.g.dart';

var tokenStorage = TokenStorage();
var httpService = HttpService();

@Riverpod(keepAlive: false)
Future<List<MobileAirtimeProduct>?> fetchMobileAirtimeProviders(
  FetchMobileAirtimeProvidersRef ref,
) async {
  try {
    var token = await tokenStorage.getToken();
    log('Token: $token');

    var response = await httpService.getRequest(
      MobileEndpoints.airtime,
      headers: {"ZEEL-SECURE-KEY": token!},
      responseType: ResponseType.plain,
    );

    if (response.statusCode == 200) {
      log('Mobile Airtime Response: ${response.data}');
      var data = jsonDecode(response.data);

      var airtimeResponse = MobileAirtimeResponse.fromJson(data);
      return airtimeResponse.products;
    } else {
      log('Failed to fetch mobile airtime providers: ${response.statusCode}');
      return null;
    }
  } on DioException catch (e) {
    log('Error fetching mobile airtime providers: $e');
    return null;
  }
}

@Riverpod(keepAlive: false)
Future<Map<String, dynamic>?> purchaseMobileAirtime(
  PurchaseMobileAirtimeRef ref, {
  required String productCode,
  required String beneficiary,
  required double amount,
  required String pin,
}) async {
  try {
    var token = await tokenStorage.getToken();
    log('Purchasing airtime: Product: $productCode, Phone: $beneficiary, Amount: $amount');

    var response = await httpService.postRequest(
      MobileEndpoints.airtime,
      data: {
        'product_code': productCode,
        'beneficiary': beneficiary,
        'amount': amount,
        'pin': pin,
      },
      headers: {"ZEEL-SECURE-KEY": token!},
    );

    if (response.statusCode == 200) {
      log('Mobile Airtime Purchase Response: ${response.data}');
      var data = jsonDecode(response.data);
      return data;
    } else {
      log('Airtime purchase failed with status: ${response.statusCode}');
      return null;
    }
  } on DioException catch (e) {
    log('Error purchasing mobile airtime: $e');
    if (e.response?.statusCode == 402) {
      throw Exception('Insufficient funds');
    } else if (e.response?.statusCode == 503) {
      throw Exception('Airtime purchase failed');
    } else if (e.response?.statusCode == 422) {
      var data = jsonDecode(e.response?.data);
      throw Exception(
          data['errors']?.values?.first?.first ?? 'Validation error');
    } else {
      throw Exception('Network error occurred');
    }
  }
}
