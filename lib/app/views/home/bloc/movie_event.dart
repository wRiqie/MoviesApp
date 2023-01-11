import 'package:movies_app/app/core/customTypes/error_func.dart';

abstract class MovieEvent {
  final int? limit;
  final ErrorFunc? onError;

  MovieEvent({this.limit, this.onError});
}

class LoadNowPlayingMoviesEvent extends MovieEvent {
  LoadNowPlayingMoviesEvent({int? limit, ErrorFunc? onError})
      : super(limit: limit, onError: onError);
}

class LoadPopularMoviesEvent extends MovieEvent {
  LoadPopularMoviesEvent({int? limit, ErrorFunc? onError})
      : super(limit: limit, onError: onError);
}

class LoadTopRatedMoviesEvent extends MovieEvent {
  LoadTopRatedMoviesEvent({int? limit, ErrorFunc? onError})
      : super(limit: limit, onError: onError);
}

class LoadTrendingMoviesEvent extends MovieEvent {
  LoadTrendingMoviesEvent({int? limit, ErrorFunc? onError})
      : super(limit: limit, onError: onError);
}

class LoadUpcomingMoviesEvent extends MovieEvent {
  LoadUpcomingMoviesEvent({int? limit, ErrorFunc? onError})
      : super(limit: limit, onError: onError);
}
