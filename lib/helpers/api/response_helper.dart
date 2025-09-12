import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ugbills/helpers/api/exceptions_helper.dart';
import 'package:ugbills/helpers/storage/token.dart';
import 'package:ugbills/services/http_service.dart';

class ApiRepository {
  ///This function handles all the api requests
  Future handleRequest(
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? data,
      ResponseType? responseType,
      bool? auth,
      File? file,
      String? key,
      required RequestType requestType,
      required String endpoint,
      required Function(dynamic) onSuccess,
      required Function(String) onError}) async {
    final HttpService httpService = HttpService();
    try {
      Response response;

      //switch case to handle request type
      headers ??= {'X-Forwarded-For': '1234', 'Y-decryption-key': '1234'};

      //add authorization header if auth is true

      if (auth != null && auth) {
        var token = await TokenStorage().getToken();
        headers.addAll({'ZEEL-SECURE-KEY': token});
      }
      switch (requestType) {
        case RequestType.get:
          response = await httpService.getRequest(
            endpoint,
            queryParameters: queryParameters,
            headers: headers,
            responseType: responseType,
          );
          break;
        case RequestType.post:
          response = await httpService.postRequest(
            endpoint,
            data: data,
            headers: headers,
          );
          break;
        case RequestType.put:
          response = await httpService.putRequest(endpoint,
              data: data, headers: headers);
          break;
        case RequestType.delete:
          response = await httpService.deleteRequest(
            endpoint,
            data: data,
            headers: headers,
          );
          break;
        case RequestType.upload:
          response = await httpService.uploadRequest(
            endpoint,
            file: file!,
            key: key!,
            headers: headers,
          );
          break;
      }

      if (response.statusCode != null && response.statusCode! <= 201) {
        onSuccess(response.data);
      }
    } on DioException catch (e) {
      //change loading state to false

      onError(ApiExceptions.getErrorMessage(e));
    }
  }
}

///enum for request type
enum RequestType { get, post, put, delete, upload }
