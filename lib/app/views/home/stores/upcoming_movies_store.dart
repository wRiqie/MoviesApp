import 'package:flutter/cupertino.dart';
import 'package:movies_app/app/data/repositories/movie_repository.dart';
import 'package:movies_app/app/views/home/states/movies_state.dart';
import 'package:movies_app/app/views/home/stores/movie_store.dart';

import '../../../data/api/error_response.dart';

class UpcomingMoviesStore extends ValueNotifier<MoviesState>
    implements MovieStore {
  final MovieRepository _repository;
  UpcomingMoviesStore(this._repository) : super(InitialMoviesState());

  @override
  Future<void> fetchAll() async {
    if (value is SuccessMoviesState) return;
    try {
      value = LoadingMoviesState();
      final movies = await _repository.getUpcoming();
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
