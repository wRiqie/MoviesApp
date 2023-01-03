import 'package:flutter/cupertino.dart';
import 'package:movies_app/app/data/repositories/details_repository.dart';
import 'package:movies_app/app/views/details/states/details_state.dart';

class DetailsStore extends ValueNotifier<DetailsState> {
  final DetailsRepository _repository;
  DetailsStore(this._repository) : super(InitialDetailsState());

  Future<void> fetchAll(int movieId) async {
    value = LoadingDetailsState();
    final details = await _repository.getDetails(movieId: movieId);
    if(details != null) {
      value = SuccessDetailsState(details);
    } else {
      value = ErrorDetailsState("Details not found!");
    }
  }
}