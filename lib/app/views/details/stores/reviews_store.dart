import 'package:flutter/cupertino.dart';
import 'package:movies_app/app/data/api/error_response.dart';
import 'package:movies_app/app/data/repositories/reviews_repository.dart';
import 'package:movies_app/app/views/details/states/reviews_state.dart';

class ReviewsStore extends ValueNotifier<ReviewsState> {
  final ReviewRepository _repository;
  int? movieId;
  ReviewsStore(this._repository) : super(InitialReviewsState());

  Future<void> fetchAll(int movieId) async {
    if (movieId == this.movieId) return;
    this.movieId = movieId;
    try {
      value = LoadingReviewsState();
      final reviews = await _repository.getReviews(movieId);
      if (reviews.error != null) {
        value = ErrorReviewsState(reviews.error!);
      } else {
        value = SuccessReviewsState(reviews.content);
      }
    } catch (e) {
      value = ErrorReviewsState(ErrorResponse.generic(e.toString()));
    }
  }
}
