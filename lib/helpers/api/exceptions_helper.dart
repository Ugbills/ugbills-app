import 'package:dio/dio.dart';

class ApiExceptions {
  static String getErrorMessage(DioException e) {
    String errorDescription = '';
    if (e.response != null) {
      switch (e.response!.statusCode) {
        case 400:
          errorDescription = 'Bad request';
          break;
        case 401:
          errorDescription = 'Unauthorized';
          break;
        case 403:
          errorDescription = 'Forbidden';
          break;
        case 404:
          errorDescription = 'Not Found';
          break;
        case 409:
          errorDescription = 'Conflict';
          break;
        case 500:
          errorDescription = 'Internal Server Error';
          break;
        case 503:
          errorDescription = 'Service Unavailable';
          break;
        default:
          errorDescription = 'Oops something went wrong';
          break;
      }
    } else {
      //check for internet connection error
      if (e.type == DioExceptionType.badCertificate) {
        errorDescription = 'Invalid SSL Certificate';
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        errorDescription = 'Connection Timeout';
      }
      if (e.type == DioExceptionType.badResponse) {
        errorDescription = 'Bad Response';
      }
      if (e.type == DioExceptionType.cancel) {
        errorDescription = 'Request Cancelled';
      }
      if (e.type == DioExceptionType.connectionError) {
        errorDescription = 'No Internet Connection';
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        errorDescription = 'Receive Timeout';
      }
      if (e.type == DioExceptionType.sendTimeout) {
        errorDescription = 'Send Timeout';
      }
      if (e.type == DioExceptionType.unknown) {
        errorDescription = 'Unknown Error';
      }
    }
    return errorDescription;
  }
}
