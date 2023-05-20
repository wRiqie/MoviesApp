import 'package:movies_app/app/data/datasources/reviews_datasource.dart';
import 'package:movies_app/app/data/models/default_response_model.dart';
import 'package:movies_app/app/data/models/review_model.dart';
import 'package:movies_app/app/data/service/execute_service.dart';

class ReviewsRepository {
  final ReviewsDatasource _reviewsDatasource;

  ReviewsRepository(this._reviewsDatasource);

  Future<DefaultResponseModel<List<ReviewModel>>> getReviews(int movieId,
      {int page = 1}) {
    return ExecuteService.tryExecuteAsync(
        execute: () => _reviewsDatasource.getReviews(movieId, page: page));
  }
}
