abstract class BaseProvider<T> {
  Future<T?> findOne({
    required String path,
    required String apiKey,
    required T Function(Map<String, dynamic>) fromMap,
    required int? connectionTimeout,
    required int? receiveTimeout,
  });

  Future<List<T>> get({
    required String path,
    required String apiKey,
    int? page,
    required T Function(Map<String, dynamic>) fromMap,
    required int? connectionTimeout,
    required int? receiveTimeout,
    int? limit
  });
}