// ignore_for_file: unused_catch_clause

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:zeelpay/constants/api/endpoints.dart';

///this class houses all the http methods
class HttpService {
  late Dio _dio;

  HttpService() {
    _dio = Dio(BaseOptions(
      baseUrl: Endpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add any request interceptors here, like adding headers
        // options.headers['Authorization'] = 'Bearer YOUR_TOKEN';
        return handler.next(options); //continue
      },
      onResponse: (response, handler) {
        // Do something with response data
        return handler.next(response); // continue
      },
      onError: (DioException e, handler) {
        // Do something with response error

        return handler.next(e); //continue
      },
    ));
  }

  /// This function handles get request
  Future<Response> getRequest(String endpoint,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      ResponseType? responseType}) async {
    try {
      Response response = await _dio.get(endpoint,
          queryParameters: queryParameters,
          options: Options(headers: headers, responseType: responseType));
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }

  /// This function handles post request
  Future<Response> postRequest(String endpoint,
      {Map<String, dynamic>? data, Map<String, dynamic>? headers}) async {
    try {
      Response response = await _dio.post(endpoint,
          data: data,
          options: Options(headers: headers, responseType: ResponseType.plain));
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }

  ///This function handles file upload
  Future<Response> putRequest(String endpoint,
      {Map<String, dynamic>? data, Map<String, dynamic>? headers}) async {
    try {
      Response response = await _dio.put(endpoint,
          data: data, options: Options(headers: headers));
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }

  /// This function handles file upload
  Future<Response> deleteRequest(String endpoint,
      {Map<String, dynamic>? data, Map<String, dynamic>? headers}) async {
    try {
      Response response = await _dio.delete(endpoint,
          data: data, options: Options(headers: headers));
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }

  /// This function handles file upload
  Future<Response> patchRequest(String endpoint,
      {Map<String, dynamic>? data, Map<String, dynamic>? headers}) async {
    try {
      Response response = await _dio.patch(endpoint,
          data: data, options: Options(headers: headers));
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }

  /// This function handles file upload
  Future<Response> uploadRequest(String endpoint,
      {Map<String, dynamic>? headers,
      required File file,
      required String key}) async {
    try {
      final formData = FormData.fromMap({
        key: await MultipartFile.fromFile(file.path),
      });
      Response response = await _dio.post(endpoint,
          data: formData, options: Options(headers: headers));
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }

  /// This function handles file upload
  Future<Response> uploadFileRequest(String endpoint,
      {Map<String, dynamic>? headers,
      required File file,
      required String fileName,
      required String key}) async {
    try {
      final formData = FormData.fromMap({
        "file_name": fileName,
        key: await MultipartFile.fromFile(file.path),
      });
      Response response = await _dio.post(endpoint,
          data: formData, options: Options(headers: headers));
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }
}
