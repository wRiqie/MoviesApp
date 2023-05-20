import 'package:movies_app/app/data/datasources/movie_datasource.dart';
import 'package:movies_app/app/data/models/default_response_model.dart';
import 'package:movies_app/app/data/service/execute_service.dart';

import '../models/movie_model.dart';

class MovieRepository {
  final MovieDatasource _movieDatasource;

  MovieRepository(this._movieDatasource);

  Future<DefaultResponseModel<List<MovieModel>>> getTrendingWeek({int? page}) {
    return ExecuteService.tryExecuteAsync(
        execute: () => _movieDatasource.getTrendingWeek(page: page));
  }

  Future<DefaultResponseModel<List<MovieModel>>> getNowPlaying({int? page}) {
    return ExecuteService.tryExecuteAsync(
        execute: () => _movieDatasource.getNowPlaying(page: page));
  }

  Future<DefaultResponseModel<List<MovieModel>>> getUpcoming({int? page}) {
    return ExecuteService.tryExecuteAsync(
        execute: () => _movieDatasource.getUpcoming(page: page));
  }

  Future<DefaultResponseModel<List<MovieModel>>> getTopRated({int? page}) {
    return ExecuteService.tryExecuteAsync(
        execute: () => _movieDatasource.getTopRated(page: page));
  }

  Future<DefaultResponseModel<List<MovieModel>>> getPopular({int? page}) {
    return ExecuteService.tryExecuteAsync(
        execute: () => _movieDatasource.getPopular(page: page));
  }
}
