import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ugbills/constants/api/mobile_endpoints.dart';
import 'package:ugbills/helpers/storage/token.dart';
import 'package:ugbills/models/api/databundle_model.dart';
import 'package:ugbills/services/http_service.dart';

part 'databundle_provider.g.dart';

var tokenStorage = TokenStorage();
var httpService = HttpService();

@Riverpod(keepAlive: false)
Future<List<DataBundleProduct>?> fetchDataBundles(
  FetchDataBundlesRef ref,
) async {
  try {
    var token = await tokenStorage.getToken();
    log('Token: $token');

    var response = await httpService.getRequest(
      MobileEndpoints.databundle,
      headers: {"ZEEL-SECURE-KEY": token!},
      responseType: ResponseType.plain,
    );

    if (response.statusCode == 200) {
      log('DataBundle Response: ${response.data}');
      var data = jsonDecode(response.data);

      var dataBundleResponse = DataBundleResponse.fromJson(data);
      return dataBundleResponse.products;
    }
  } on DioException catch (e) {
    log('Error fetching databundles: $e');
    throw Exception('Failed to fetch data bundles: ${e.message}');
  }
  return null;
}
