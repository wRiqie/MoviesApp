import 'package:flutter/cupertino.dart';
import 'package:movies_app/app/views/home/states/movies_state.dart';

abstract class MovieStore extends ValueNotifier<MoviesState> {
  MovieStore() : super(InitialMoviesState());

  Future<void> fetchAll({int? limit});
}