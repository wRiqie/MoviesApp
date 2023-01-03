import 'package:flutter/material.dart';
import 'package:movies_app/app/data/repositories/movie_repository.dart';
import 'package:movies_app/app/views/home/states/movies_state.dart';
import 'package:movies_app/app/views/home/stores/movie_store.dart';

class TrendingMoviesStore extends ValueNotifier<MoviesState> implements MovieStore {
  final MovieRepository _repository;
  TrendingMoviesStore(this._repository) : super(InitialMoviesState());

  @override
  Future<void> fetchAll() async {
    value = LoadingMoviesState();
    final movies = await _repository.getTrendingWeek();
    value = SuccessMoviesState(movies);
  }
}
