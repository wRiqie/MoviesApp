import 'package:flutter/cupertino.dart';
import 'package:movies_app/app/data/api/error_response.dart';
import 'package:movies_app/app/data/repositories/movie_repository.dart';
import 'package:movies_app/app/views/home/states/movies_state.dart';
import 'package:movies_app/app/views/home/stores/movie_store.dart';

class NowPlayingMoviesStore extends ValueNotifier<MoviesState>
    implements MovieStore {
  final MovieRepository _repository;
  NowPlayingMoviesStore(this._repository) : super(InitialMoviesState());

  @override
  Future<void> fetchAll() async {
    if (value is SuccessMoviesState) return;
    try {
      value = LoadingMoviesState();
      final movies = await _repository.getNowPlaying();
      value = SuccessMoviesState(movies);
    } catch (e) {
      final errorResponse = ErrorResponse(code: 0, message: e.toString());
      value = ErrorMoviesState(errorResponse);
    }
  }
}
