import 'package:movies_app/app/data/models/provider_response.dart';

abstract class BaseProvider<T> {
  Future<ProviderResponse<T?>> findOne({
    required String path,
    required String apiKey,
    required T Function(Map<String, dynamic>) fromMap,
    required int? connectionTimeout,
    required int? receiveTimeout,
  });

  Future<ProviderResponse<List<T>>> get({
    required String path,
    required String apiKey,
    int? page,
    required T Function(Map<String, dynamic>) fromMap,
    required int? connectionTimeout,
    required int? receiveTimeout,
    int? limit
  });
}