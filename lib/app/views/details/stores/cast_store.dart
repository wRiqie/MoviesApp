import 'package:flutter/cupertino.dart';
import 'package:movies_app/app/data/api/error_response.dart';
import 'package:movies_app/app/data/repositories/cast_repository.dart';
import 'package:movies_app/app/views/details/states/cast_state.dart';

class CastStore extends ValueNotifier<CastState> {
  final CastRepository _repository;
  int? movieId;
  CastStore(this._repository) : super(InitialCastState());

  Future<void> fetchAll(int movieId) async {
    if (movieId == this.movieId) return;
    this.movieId = movieId;
    try {
      value = LoadingCastState();
      final cast = await _repository.getMovieCast(movieId);
      if (cast.error != null) {
        value = ErrorCastState(cast.error!);
      } else if (cast.content != null) {
        value = SuccessCastState(cast.content!);
      } else {
        value = ErrorCastState(ErrorResponse.generic('Cast not found!'));
      }
    } catch (e) {
      value = ErrorCastState(ErrorResponse.generic(e.toString()));
    }
  }
}
