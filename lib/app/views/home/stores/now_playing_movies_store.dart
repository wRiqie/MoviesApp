import 'package:flutter/cupertino.dart';
import 'package:movies_app/app/data/repositories/movie_repository.dart';
import 'package:movies_app/app/views/home/states/movies_state.dart';
import 'package:movies_app/app/views/home/stores/movie_store.dart';

class NowPlayingMoviesStore extends ValueNotifier<MoviesState> implements MovieStore {
  final MovieRepository _repository;
  NowPlayingMoviesStore(this._repository) : super(InitialMoviesState());

  @override
  Future<void> fetchAll() async {
    value = LoadingMoviesState();
    final movies = await _repository.getNowPlaying();
    value = SuccessMoviesState(movies);
  }
}