import 'package:flutter/cupertino.dart';
import 'package:movies_app/app/views/movie_list/states/movies_list_state.dart';

abstract class MoviesListStore extends ValueNotifier<MoviesListState> {
  MoviesListStore() : super(InitialMoviesListState());
  
  Future<void> fetch({int? page});
}