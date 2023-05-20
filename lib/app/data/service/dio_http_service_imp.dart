import 'package:dio/dio.dart';
import 'package:movies_app/app/core/utils/env_util.dart';
import 'package:movies_app/app/core/values/constants.dart';
import 'package:movies_app/app/data/models/extra_options_model.dart';
import 'package:movies_app/app/data/service/http_service.dart';

class DioHttpServiceImp implements HttpService {
  final Dio _dio;

  DioHttpServiceImp(this._dio);

  @override
  Future get(String path, {ExtraOptionsModel? options}) async {
    await setOptions(options: options);
    return _dio.get(
      path,
      data: options?.data,
      queryParameters: options?.queryParameters,
    );
  }

  Future<void> setOptions({ExtraOptionsModel? options}) async {
    _dio.options = BaseOptions(
      baseUrl: options?.baseUrl ?? Constants.baseUrl,
      headers: options?.headers,
      queryParameters: (options?.queryParameters ?? {})
        ..addAll({'api_key': await EnvUtil.get(Constants.apiKey)}),
      connectTimeout: Duration(milliseconds: options?.connectTimeout ?? 10000),
      receiveTimeout: Duration(milliseconds: options?.receiveTimeout ?? 10000),
      contentType: options?.contentType,
      responseType: options?.responseType ?? ResponseType.json,
    );
  }
}
