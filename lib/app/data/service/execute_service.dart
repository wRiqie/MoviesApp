import 'package:dio/dio.dart';
import 'package:movies_app/app/core/values/error_constants.dart';
import 'package:movies_app/app/data/models/default_response_model.dart';
import 'package:movies_app/app/data/models/error_model.dart';

class ExecuteService {
  ExecuteService._();

  static Future<DefaultResponseModel<T>> tryExecuteAsync<T>(
      {required Future<T?> Function() execute}) async {
    try {
      final result = await execute();
      return DefaultResponseModel(data: result);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        return DefaultResponseModel(
            error: ErrorModel(
          code: e.response?.statusCode,
          message: ErrorConstants.timeoutError,
        ));
      } else if (e.type == DioErrorType.badResponse) {
        return DefaultResponseModel(
            error: ErrorModel(
          code: e.response?.statusCode,
          message: e.message ?? ErrorConstants.unknownnError,
        ));
      } else {
        return DefaultResponseModel(
            error: ErrorModel(
          code: e.response?.statusCode,
          message: ErrorConstants.unknownnError,
        ));
      }
    }
  }
}
