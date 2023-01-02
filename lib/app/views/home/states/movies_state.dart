import 'package:movies_app/app/data/api/error_response.dart';
import 'package:movies_app/app/data/models/movie.dart';

abstract class MoviesState {}

class InitialMoviesState extends MoviesState {}

class LoadingMoviesState extends MoviesState {}

class SuccessMoviesState extends MoviesState {
  final List<Movie> movies;

  SuccessMoviesState(this.movies);
}

class ErrorMoviesState extends MoviesState {
  final ErrorResponse error;

  ErrorMoviesState(this.error);
}