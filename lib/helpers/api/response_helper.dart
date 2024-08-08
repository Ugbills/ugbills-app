import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeelpay/helpers/api/exceptions_helper.dart';
import 'package:zeelpay/services/http_service.dart';

class ApiRepository {
  ///This function handles all the api requests
  Future handleRequest(
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? data,
      ResponseType? responseType,
      File? file,
      String? key,
      AutoDisposeStateProvider<bool>? loadingProvider,
      WidgetRef? ref,
      required RequestType requestType,
      required String endpoint,
      required Function(dynamic) onSuccess,
      required Function(String) onError}) async {
    final HttpService httpService = HttpService();
    try {
      Response response;

      if (loadingProvider != null && ref != null) {
        ref.read(loadingProvider.notifier).state = true;
      }
      //switch case to handle request type
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
          response = await httpService.patchUploadRequest(
            endpoint,
            data: data,
            file: file!,
            key: key!,
            headers: headers,
          );
          break;
      }

      //change loading state to false
      if (loadingProvider != null && ref != null) {
        ref.read(loadingProvider.notifier).state = false;
      }

      if (response.statusCode != null && response.statusCode! <= 201) {
        onSuccess(response.data);
      }
    } on DioException catch (e) {
      //change loading state to false
      if (loadingProvider != null && ref != null) {
        ref.read(loadingProvider.notifier).state = false;
      }
      onError(ApiExceptions.getErrorMessage(e));
    }
  }
}

///enum for request type
enum RequestType { get, post, put, delete, upload }
