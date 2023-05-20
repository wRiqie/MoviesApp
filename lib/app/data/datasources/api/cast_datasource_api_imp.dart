import 'package:movies_app/app/data/datasources/cast_datasource.dart';
import 'package:movies_app/app/data/models/extra_options_model.dart';
import 'package:movies_app/app/data/models/movie_actors_model.dart';
import 'package:movies_app/app/data/service/http_service.dart';

import '../../../core/utils/env_util.dart';
class CastDatasourceApiImp implements CastDatasource {
  final HttpService _httpService;

  CastDatasourceApiImp(this._httpService);

  @override
  Future<MovieActorsModel?> getMovieCast(int movieId) async {
    final response = await _httpService.get('/movie/$movieId/credits');
    return response.data != null ? MovieActorsModel.fromMap(response) : null;
  }
}
