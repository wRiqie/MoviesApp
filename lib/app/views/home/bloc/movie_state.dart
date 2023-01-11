import 'package:movies_app/app/data/models/movie.dart';

abstract class MovieState {}

class IdleMovieState extends MovieState {}

class LoadingMovieState extends MovieState {}

class SuccessMovieState extends MovieState {
  final List<Movie> movies;

  SuccessMovieState({
    required this.movies,
  });
}

class ErrorMovieState extends MovieState {
  final String message;

  ErrorMovieState({
    required this.message,
  });
}
