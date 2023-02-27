import 'package:movies_app/app/data/api/error_response.dart';

import '../../../data/models/movie.dart';

abstract class MoviesListState {}

class InitialMoviesListState extends MoviesListState {}

class LoadingMoviesListState extends MoviesListState {}

class SuccessMoviesListState extends MoviesListState {
  final List<Movie> movies;

  SuccessMoviesListState(this.movies);
}

class ErrorMoviesListState extends MoviesListState {
  final ErrorResponse error;

  ErrorMoviesListState(this.error);
}