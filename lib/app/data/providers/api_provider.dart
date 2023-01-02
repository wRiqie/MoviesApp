import '../api/api_request.dart';
import 'base_provider.dart';

class ApiProvider<T> implements BaseProvider<T> {
  @override
  Future<List<T>> get(
      {required String path,
      required String apiKey,
      int? page,
      Function(String)? onError,
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
        if (onError != null) {
          onError(apiResponse.errorResponse?.message ??
              'Ocorreu um erro inesperado...');
        }
        return [];
      }

      List<T> list = [];

      final results = apiResponse.response?.data['results'];
      int limitItems = limit ?? results.length;

      for (var i = 0; i < limitItems; i++) {
        list.add(fromMap(results[i]));
      }

      return list;
    } catch (e) {
      if (onError != null) onError(e.toString());
      return [];
    }
  }

  @override
  Future<T?> findOne({
    required String path,
    required String apiKey,
    Function(String)? onError,
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
        if (onError != null) {
          onError(apiResponse.errorResponse?.message ??
              'Ocorreu um erro inesperado...');
        }
        return null;
      }

      final result = apiResponse.response?.data;

      return fromMap(result);
    } catch (e) {
      if (onError != null) onError(e.toString());
      return null;
    }
  }
}
