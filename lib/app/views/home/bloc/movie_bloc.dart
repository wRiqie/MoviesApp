import 'dart:async';

import 'package:movies_app/app/data/models/movie.dart';
import 'package:movies_app/app/data/repositories/movie_repository.dart';
import 'package:movies_app/app/views/home/bloc/movie_event.dart';
import 'package:movies_app/app/views/home/bloc/movie_state.dart';

class MovieBloc {
  final MovieRepository repository;

  final StreamController<MovieEvent> _inputMovieController = StreamController();
  final StreamController<MovieState> _outputMovieController =
      StreamController();

  Sink<MovieEvent> get inputMovie => _inputMovieController.sink;
  Stream<MovieState> get stream => _outputMovieController.stream;

  MovieBloc(this.repository) {
    _inputMovieController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(MovieEvent event) async {
    try {
      _outputMovieController.add(LoadingMovieState());
      List<Movie> movies = [];

      if (event is LoadNowPlayingMoviesEvent) {
        movies = await repository.getNowPlaying(
          limit: event.limit,
          onError: event.onError,
        );
      } else if (event is LoadPopularMoviesEvent) {
        movies = await repository.getPopular(
          limit: event.limit,
          onError: event.onError,
        );
      } else if (event is LoadTopRatedMoviesEvent) {
        movies = await repository.getTopRated(
          limit: event.limit,
          onError: event.onError,
        );
      } else if (event is LoadTrendingMoviesEvent) {
        movies = await repository.getTrendingWeek(
          limit: event.limit,
          onError: event.onError,
        );
      } else if (event is LoadUpcomingMoviesEvent) {
        movies = await repository.getUpcoming(
          limit: event.limit,
          onError: event.onError,
        );
      }

      _outputMovieController.add(SuccessMovieState(movies: movies));
    } catch (e) {
      _outputMovieController.add(ErrorMovieState(message: e.toString()));
    }
  }
}
