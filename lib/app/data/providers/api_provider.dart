import 'package:movies_app/app/data/api/error_response.dart';
import 'package:movies_app/app/data/models/provider_response.dart';

import '../api/api_request.dart';
import 'base_provider.dart';

class ApiProvider<T> implements BaseProvider<T> {
  @override
  Future<ProviderResponse<List<T>>> get(
      {required String path,
      required String apiKey,
      int? page,
      required T Function(Map<String, dynamic>) fromMap,
      required int? connectionTimeout,
      required int? receiveTimeout,
      int? limit}) async {
    try {
      final apiResponse = await ApiRequest(
        apiKey: apiKey,
        connectionTimeout: connectionTimeout,
        receiveTimeout: receiveTimeout,
      ).getAsync(url: path, queryParameters: {'page': page});

      if (apiResponse.errorResponse != null) {
        return ProviderResponse(content: [], error: apiResponse.errorResponse);
      }

      List<T> list = [];

      final results = apiResponse.response?.data['results'];
      int limitItems = limit ?? results.length;

      for (var i = 0; i < limitItems; i++) {
        list.add(fromMap(results[i]));
      }

      return ProviderResponse(content: list);
    } catch (e) {
      return ProviderResponse(
        content: [],
        error: ErrorResponse.generic(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<ProviderResponse<T?>> findOne({
    required String path,
    required String apiKey,
    required T Function(Map<String, dynamic> p1) fromMap,
    required int? connectionTimeout,
    required int? receiveTimeout,
  }) async {
    try {
      final apiResponse = await ApiRequest(
        apiKey: apiKey,
        connectionTimeout: connectionTimeout,
        receiveTimeout: receiveTimeout,
      ).getAsync(url: path);

      if (apiResponse.errorResponse != null) {
        return ProviderResponse(
          content: null,
          error: apiResponse.errorResponse,
        );
      }

      final result = apiResponse.response?.data;

      return ProviderResponse(content: fromMap(result));
    } catch (e) {
      return ProviderResponse(
        content: null,
        error: ErrorResponse.generic(
          e.toString(),
        ),
      );
    }
  }
}
