import 'package:movies_app/app/data/api/error_response.dart';
import 'package:movies_app/app/data/models/review_model.dart';

abstract class ReviewsState {}

class InitialReviewsState extends ReviewsState {}

class LoadingReviewsState extends ReviewsState {}

class SuccessReviewsState extends ReviewsState {
  final List<ReviewModel> reviews;

  SuccessReviewsState(this.reviews);
}

class ErrorReviewsState extends ReviewsState {
  final ErrorResponse error;

  ErrorReviewsState(this.error);
}
