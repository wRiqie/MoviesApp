import '../models/review_model.dart';

abstract class ReviewsDatasource {
  Future<List<ReviewModel>> getReviews(int movieId, {int? limit, int page = 1});
}
