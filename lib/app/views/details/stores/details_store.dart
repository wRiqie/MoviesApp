import 'package:flutter/cupertino.dart';
import 'package:movies_app/app/data/api/error_response.dart';
import 'package:movies_app/app/data/repositories/details_repository.dart';
import 'package:movies_app/app/views/details/states/details_state.dart';

class DetailsStore extends ValueNotifier<DetailsState> {
  final DetailsRepository _repository;
  DetailsStore(this._repository) : super(InitialDetailsState());

  Future<void> fetchAll(int movieId) async {
    value = LoadingDetailsState();
    try {
      final details = await _repository.getDetails(movieId: movieId);
      if (details.error != null) {
        value = ErrorDetailsState(details.error!);
      } else if (details.content != null) {
        value = SuccessDetailsState(details.content!);
      } else {
        value = ErrorDetailsState(ErrorResponse.generic("Details not found!"));
      }
    } catch (e) {
      value = ErrorDetailsState(ErrorResponse.generic(e.toString()));
    }
  }
}
