import 'package:movies_app/app/core/customTypes/error_func.dart';
import 'package:movies_app/app/data/models/review.dart';
import 'package:movies_app/app/data/providers/base_provider.dart';

import '../../core/utils/env_util.dart';
import '../../core/values/constants.dart';

class ReviewRepository {
  final BaseProvider<Review> _provider;

  ReviewRepository(this._provider);

  Future<List<Review>> getReviews(
    int movieId, {
    int? limit,
    int page = 1,
    ErrorFunc? onError,
  }) async =>
      await _provider.get(
        path: '/movie/$movieId/reviews',
        apiKey: await EnvUtil.get(Constants.apiKey),
        page: page,
        fromMap: Review.fromMap,
        connectionTimeout: null,
        receiveTimeout: null,
        limit: limit,
        onError: onError,
      );
}
