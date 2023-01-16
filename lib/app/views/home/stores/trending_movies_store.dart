import 'package:flutter/material.dart';
import 'package:movies_app/app/data/repositories/movie_repository.dart';
import 'package:movies_app/app/views/home/states/movies_state.dart';
import 'package:movies_app/app/views/home/stores/movie_store.dart';

import '../../../data/api/error_response.dart';

class TrendingMoviesStore extends ValueNotifier<MoviesState>
    implements MovieStore {
  final MovieRepository _repository;
  TrendingMoviesStore(this._repository) : super(InitialMoviesState());

  @override
  Future<void> fetchAll() async {
    if (value is SuccessMoviesState) return;
    try {
      // final errorResponse = ErrorResponse.generic('Não foi possível encontrar os filmes');
      // value = ErrorMoviesState(errorResponse);
      // return;
      value = LoadingMoviesState();
      final movies = await _repository.getTrendingWeek();
      if (movies.error != null) {
        value = ErrorMoviesState(movies.error!);
      } else {
        value = SuccessMoviesState(movies.content);
      }
    } catch (e) {
      final errorResponse = ErrorResponse.generic(e.toString());
      value = ErrorMoviesState(errorResponse);
    }
  }
}
