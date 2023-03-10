import 'package:movies_app/app/data/api/error_response.dart';
import 'package:movies_app/app/data/models/movie_actors.dart';

abstract class CastState {}

class InitialCastState extends CastState {}

class LoadingCastState extends CastState {}

class SuccessCastState extends CastState {
  final MovieActors movieActors;

  SuccessCastState(this.movieActors);
}

class ErrorCastState extends CastState {
  final ErrorResponse error;

  ErrorCastState(this.error);
}