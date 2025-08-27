import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zeelpay/constants/api/endpoints.dart';
import 'package:zeelpay/helpers/api/response_helper.dart';
import 'package:zeelpay/helpers/storage/token.dart';
import 'package:zeelpay/models/api/dataplans_model.dart';
import 'package:zeelpay/models/api/networks_model.dart';
import 'package:zeelpay/services/http_service.dart';

part 'network_provider.g.dart';

final ApiRepository api = ApiRepository();

final TokenStorage tokenStorage = TokenStorage();

final HttpService httpService = HttpService();

@Riverpod(keepAlive: true)
Future<NetworksModel?> getNetworks(GetNetworksRef ref) async {
  try {
    var token = await tokenStorage.getToken();
    var response = await httpService.getRequest(Endpoints.networks,
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
        responseType: ResponseType.plain);
    if (response.statusCode == 200) {
      return NetworksModel.fromJson(jsonDecode(response.data));
    }
  } on DioException catch (e) {
    throw Exception(e);
  }
  return null;
}

@Riverpod(keepAlive: true)
Future<DataPlansModel?> getDataPlans(GetDataPlansRef ref,
    {required String networkId}) async {
  try {
    var token = await tokenStorage.getToken();
    var response = await httpService.getRequest(Endpoints.dataPlans + networkId,
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
        responseType: ResponseType.plain);
    if (response.statusCode == 200) {
      return DataPlansModel.fromJson(jsonDecode(response.data));
    }
  } on DioException catch (e) {
    throw Exception(e);
  }
  return null;
}
