import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ugbills/constants/api/mobile_endpoints.dart';
import 'package:ugbills/helpers/storage/token.dart';
import 'package:ugbills/models/api/mobile_electricity_model.dart';
import 'package:ugbills/services/http_service.dart';

part 'mobile_electricity_provider.g.dart';

var tokenStorage = TokenStorage();
var httpService = HttpService();

@Riverpod(keepAlive: false)
Future<List<MobileElectricityProduct>?> fetchMobileElectricityProviders(
  FetchMobileElectricityProvidersRef ref,
) async {
  try {
    var token = await tokenStorage.getToken();
    log('Token: $token');

    var response = await httpService.getRequest(
      MobileEndpoints.electricity,
      headers: {"ZEEL-SECURE-KEY": token!},
      responseType: ResponseType.plain,
    );

    if (response.statusCode == 200) {
      log('Mobile Electricity Response: ${response.data}');
      var data = jsonDecode(response.data);

      var electricityResponse = MobileElectricityResponse.fromJson(data);
      return electricityResponse.products;
    }
  } on DioException catch (e) {
    log('Error fetching mobile electricity providers: $e');
    throw Exception('Failed to fetch electricity providers: ${e.message}');
  }
  return null;
}

@Riverpod(keepAlive: false)
Future<String?> validateMobileElectricityMeter(
  ValidateMobileElectricityMeterRef ref, {
  required String productCode,
  required String meterNumber,
  required String meterType,
}) async {
  try {
    var token = await tokenStorage.getToken();
    log('Validating meter: $meterNumber, Product: $productCode, Type: $meterType');

    var response = await httpService.postRequest(
      '${MobileEndpoints.electricity}/verify',
      data: {
        'product_code': productCode,
        'meter_number': meterNumber,
        'type': meterType.toLowerCase(),
      },
      headers: {"ZEEL-SECURE-KEY": token!},
    );

    if (response.statusCode == 200) {
      log('Mobile Electricity Validation Response: ${response.data}');
      var data = jsonDecode(response.data);
      return data['customer_name'] as String?;
    } else {
      log('Validation failed with status: ${response.statusCode}');
      return null;
    }
  } on DioException catch (e) {
    log('Error validating mobile electricity meter: $e');
    if (e.response?.statusCode == 404) {
      throw Exception('Invalid meter number or customer not found');
    } else if (e.response?.statusCode == 503) {
      throw Exception('Unable to verify meter number at this time');
    } else {
      throw Exception('Failed to validate meter: ${e.message}');
    }
  }
}
