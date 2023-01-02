import 'package:dio/dio.dart';

import 'error_response.dart';

class ApiResponse {
  Response? response;
  ErrorResponse? errorResponse;

  ApiResponse({
    this.response,
    this.errorResponse,
  });
}