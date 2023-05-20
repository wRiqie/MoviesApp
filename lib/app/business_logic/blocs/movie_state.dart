import 'package:movies_app/app/business_logic/base_state.dart';
import 'package:movies_app/app/data/models/movie_model.dart';

import '../../data/models/error_model.dart';

enum MovieStatus {
  idle,
  loading,
  success,
  error;

  bool get isLoading => this == MovieStatus.loading;
  bool get isSuccess => this == MovieStatus.loading;
  bool get isError => this == MovieStatus.loading;
}

class MovieState extends BaseState<MovieStatus> {
  final List<MovieModel> trendingMovies;
  final List<MovieModel> nowPlayingMovies;
  final List<MovieModel> upcomingMovies;
  final List<MovieModel> topRatedMovies;
  final List<MovieModel> popularMovies;

  MovieState({
    super.status = MovieStatus.idle,
    super.error,
    super.loadingMessage,
    this.trendingMovies = const [],
    this.nowPlayingMovies = const [],
    this.upcomingMovies = const [],
    this.topRatedMovies = const [],
    this.popularMovies = const [],
  });

  MovieState copyWith({
    required MovieStatus status,
    ErrorModel? error,
    List<MovieModel>? trendingMovies,
    List<MovieModel>? nowPlayingMovies,
    List<MovieModel>? upcomingMovies,
    List<MovieModel>? topRatedMovies,
    List<MovieModel>? popularMovies,
  }) {
    return MovieState(
      status: status,
      error: error ?? this.error,
      trendingMovies: trendingMovies ?? this.trendingMovies,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      popularMovies: popularMovies ?? this.popularMovies,
    );
  }
}
