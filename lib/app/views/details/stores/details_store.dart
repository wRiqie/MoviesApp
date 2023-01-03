import 'package:flutter/cupertino.dart';
import 'package:movies_app/app/data/repositories/details_repository.dart';
import 'package:movies_app/app/views/details/states/details_state.dart';

class DetailsStore extends ValueNotifier<DetailsState> {
  final DetailsRepository repository;
  DetailsStore(this.repository) : super(InitialDetailsState());

  Future<void> fetchAll(int movieId) async {
    value = LoadingDetailsState();
    final details = await repository.getDetails(movieId: movieId);
    if(details != null) {
      value = SuccessDetailsState(details);
    } else {
      value = ErrorDetailsState("Details not found!");
    }
  }
}