import 'package:flutter/cupertino.dart';
import 'package:movies_app/app/data/enum/loading_enum.dart';
import 'package:movies_app/app/data/models/movie_details.dart';
import 'package:movies_app/app/data/repositories/details_repository.dart';

class DetailsController {
  final int movieId; 
  final DetailsRepository repository;
  ValueNotifier<ELoading> state = ValueNotifier(ELoading.idle);
  MovieDetails? details;

  DetailsController(this.repository, {required this.movieId}) {
    loadDetails();
  } 

  void loadDetails() {
    state.value = ELoading.loading;
    repository.getDetails(movieId: movieId).then((value) {
    state.value = ELoading.success;
      details = value;
    });
  }
}