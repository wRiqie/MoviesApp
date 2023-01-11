import 'package:flutter/cupertino.dart';
import 'package:movies_app/app/data/repositories/reviews_repository.dart';
import 'package:movies_app/app/views/details/states/reviews_state.dart';

class ReviewsStore extends ValueNotifier<ReviewsState> {
  final ReviewRepository _repository;
  ReviewsStore(this._repository) : super(InitialReviewsState());

  Future<void> fetchAll(int movieId) async {
    value = LoadingReviewsState();
    final reviews = await _repository.getReviews(movieId);
    value = SuccessReviewsState(reviews);
  }
}