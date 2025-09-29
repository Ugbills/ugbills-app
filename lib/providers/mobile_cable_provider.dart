import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ugbills/constants/api/mobile_endpoints.dart';
import 'package:ugbills/helpers/storage/token.dart';
import 'package:ugbills/models/api/mobile_cable_model.dart';
import 'package:ugbills/services/http_service.dart';

part 'mobile_cable_provider.g.dart';

var tokenStorage = TokenStorage();
var httpService = HttpService();

@Riverpod(keepAlive: false)
Future<List<MobileCableProduct>?> fetchMobileCableProviders(
  FetchMobileCableProvidersRef ref,
) async {
  try {
    var token = await tokenStorage.getToken();
    log('Token: $token');

    var response = await httpService.getRequest(
      MobileEndpoints.cable,
      headers: {"ZEEL-SECURE-KEY": token!},
      responseType: ResponseType.plain,
    );

    if (response.statusCode == 200) {
      log('Mobile Cable Response: ${response.data}');
      var data = jsonDecode(response.data);

      var cableResponse = MobileCableResponse.fromJson(data);
      return cableResponse.products;
    } else {
      log('Failed to fetch mobile cable providers: ${response.statusCode}');
      return null;
    }
  } on DioException catch (e) {
    log('Error fetching mobile cable providers: $e');
    return null;
  }
}

@Riverpod(keepAlive: false)
Future<String?> validateMobileCableSmartcard(
  ValidateMobileCableSmartcardRef ref, {
  required String productCode,
  required String smartcard,
}) async {
  try {
    var token = await tokenStorage.getToken();
    log('Validating smartcard: $smartcard, Product: $productCode');

    var response = await httpService.postRequest(
      '${MobileEndpoints.cable}/verify',
      data: {
        'product_code': productCode,
        'smartcard': smartcard,
      },
      headers: {"ZEEL-SECURE-KEY": token!},
    );

    if (response.statusCode == 200) {
      log('Mobile Cable Validation Response: ${response.data}');
      var data = jsonDecode(response.data);
      return data['customer_name'] as String?;
    } else {
      log('Validation failed with status: ${response.statusCode}');
      return null;
    }
  } on DioException catch (e) {
    log('Error validating mobile cable smartcard: $e');
    if (e.response?.statusCode == 404) {
      throw Exception('Invalid smartcard / IUC number');
    } else if (e.response?.statusCode == 503) {
      throw Exception('Unable to verify smartcard at this time');
    } else {
      throw Exception('Network error occurred');
    }
  }
}

@Riverpod(keepAlive: false)
Future<Map<String, dynamic>?> purchaseMobileCable(
  PurchaseMobileCableRef ref, {
  required String productCode,
  required String variationCode,
  required String smartcard,
  required String pin,
}) async {
  try {
    var token = await tokenStorage.getToken();
    log('Purchasing cable: Product: $productCode, Variation: $variationCode, Smartcard: $smartcard');

    var response = await httpService.postRequest(
      MobileEndpoints.cable,
      data: {
        'product_code': productCode,
        'variation_code': variationCode,
        'smartcard': smartcard,
        'pin': pin,
      },
      headers: {"ZEEL-SECURE-KEY": token},
    );

    if (response.statusCode == 200) {
      log('Mobile Cable Purchase Response: ${response.data}');
      var data = jsonDecode(response.data);
      return data;
    } else {
      log('Failed to purchase mobile cable: ${response.statusCode}');
      return null;
    }
  } on DioException catch (e) {
    log('Error purchasing mobile cable: $e');
    return null;
  }
}
