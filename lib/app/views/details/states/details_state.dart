import 'package:movies_app/app/data/api/error_response.dart';
import 'package:movies_app/app/data/models/movie_details.dart';

abstract class DetailsState {}

class InitialDetailsState extends DetailsState {}

class LoadingDetailsState extends DetailsState {}

class SuccessDetailsState extends DetailsState {
  final MovieDetails details;

  SuccessDetailsState(this.details);
}

class ErrorDetailsState extends DetailsState {
  final ErrorResponse error;

  ErrorDetailsState(this.error);
}
