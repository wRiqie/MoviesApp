import 'dart:io';

import 'package:dio/dio.dart';
import 'package:movies_app/app/core/values/constants.dart';
import 'package:movies_app/app/data/api/api_response.dart';

import 'error_response.dart';

class ApiRequest {
  late final Dio _dio;
  String apiKey;

  ApiRequest({
    required this.apiKey,
    String? baseUrl,
    required int? connectionTimeout,
    required int? receiveTimeout,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? Constants.baseUrl,
        connectTimeout: connectionTimeout,
        receiveTimeout: receiveTimeout,
        queryParameters: {'api_key': apiKey}
      ),
    );
  }

  Future<ApiResponse> getAsync(
      {required String url, Map<String, dynamic>? queryParameters}) async {
    try {
      final data = await _dio.get(url, queryParameters: queryParameters);
      return ApiResponse(response: data);
    } on DioError catch (e) {
      return ApiResponse(
          errorResponse: ErrorResponse(code: e.hashCode, message: e.message));
    } on HttpException catch (e) {
      return ApiResponse(
          errorResponse: ErrorResponse(code: e.hashCode, message: e.message));
    } catch (e) {
      return ApiResponse(
          errorResponse: ErrorResponse(code: 0, message: e.toString()));
    }
  }
}
