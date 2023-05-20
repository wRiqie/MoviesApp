import 'package:movies_app/app/data/datasources/cast_datasource.dart';
import 'package:movies_app/app/data/models/default_response_model.dart';
import 'package:movies_app/app/data/models/movie_actors_model.dart';
import 'package:movies_app/app/data/service/execute_service.dart';

class CastRepository {
  final CastDatasource _castDatasource;

  CastRepository(this._castDatasource);

  Future<DefaultResponseModel<MovieActorsModel>> getMovieCast(int movieId) {
    return ExecuteService.tryExecuteAsync(
        execute: () => _castDatasource.getMovieCast(movieId));
  }
}
