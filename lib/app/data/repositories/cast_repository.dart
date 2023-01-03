import 'package:movies_app/app/data/models/actor.dart';
import 'package:movies_app/app/data/models/movie_actors.dart';
import 'package:movies_app/app/data/providers/api_provider.dart';

import '../../core/utils/env_util.dart';
import '../../core/values/constants.dart';

class CastRepository {
  final ApiProvider<MovieActors> _provider;

  CastRepository(this._provider);

  Future<MovieActors?> getMovieCast(int movieId)
    async => await _provider.findOne(
        path: '/movie/$movieId/credits',
        apiKey: await EnvUtil.get(Constants.apiKey),
        fromMap: MovieActors.fromMap,
        connectionTimeout: null,
        receiveTimeout: null,
      ); 
}