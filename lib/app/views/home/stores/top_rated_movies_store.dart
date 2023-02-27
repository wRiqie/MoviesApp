import 'package:flutter/cupertino.dart';
import 'package:movies_app/app/data/repositories/movie_repository.dart';
import 'package:movies_app/app/views/home/states/movies_state.dart';
import 'package:movies_app/app/views/home/stores/movie_store.dart';

import '../../../data/api/error_response.dart';

class TopRatedMoviesStore extends ValueNotifier<MoviesState>
    implements MovieStore {
  final MovieRepository _repository;
  TopRatedMoviesStore(this._repository) : super(InitialMoviesState());

  @override
  Future<void> fetchAll({int? limit}) async {
    if (value is SuccessMoviesState) return;
    try {
      value = LoadingMoviesState();
      final movies = await _repository.getTopRated(limit: limit);
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
