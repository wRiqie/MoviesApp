import 'package:flutter/cupertino.dart';
import 'package:movies_app/app/data/repositories/cast_repository.dart';
import 'package:movies_app/app/views/details/states/cast_state.dart';

class CastStore extends ValueNotifier<CastState> {
  final CastRepository _repository;
  CastStore(this._repository) : super(InitialCastState());

  Future<void> fetchAll(int movieId) async {
    value = LoadingCastState();
    final cast = await _repository.getMovieCast(movieId);
    if(cast != null) {
      value = SuccessCastState(cast);
    } else {
      value = ErrorCastState('Cast not found!');
    }
  }
}