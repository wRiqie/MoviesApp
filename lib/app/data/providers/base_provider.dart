abstract class BaseProvider<T> {
  Future<List<T>> get({
    required String path,
    required String apiKey,
    int? page,
    Function(String)? onError,
    required T Function(Map<String, dynamic>) fromMap,
    required int? connectionTimeout,
    required int? receiveTimeout,
    int? limit
  });

  Future<T?> findOne({
    required String path,
    required String apiKey,
    Function(String)? onError,
    required T Function(Map<String, dynamic>) fromMap,
    required int? connectionTimeout,
    required int? receiveTimeout,
  });
}