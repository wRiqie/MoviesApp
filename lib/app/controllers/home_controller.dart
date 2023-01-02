import 'package:flutter/material.dart';
import 'package:movies_app/app/data/enum/loading_enum.dart';
import 'package:movies_app/app/data/models/movie.dart';
import 'package:movies_app/app/data/repositories/movie_repository.dart';

class HomeController {
  List<Movie> upcomingMovies = [];
  final MovieRepository repository;
  ValueNotifier<ELoading> state = ValueNotifier(ELoading.idle);

  HomeController(this.repository) {
    getTrendingMovies();
  }

  void getTrendingMovies() {
    state.value = ELoading.loading;
    repository.getTrendingWeek().then((value) {
      state.value = ELoading.success;
      upcomingMovies = value;
    });
  }

  Future<List<Movie>> getNowPlaying() => repository.getNowPlaying();
  Future<List<Movie>> getUpcoming() => repository.getUpcoming();
  Future<List<Movie>> getTopRated() => repository.getTopRated();
  Future<List<Movie>> getPopular() => repository.getPopular();
}
