import 'package:movies_app/app/data/models/movie_actors.dart';
import 'package:movies_app/app/data/models/provider_response.dart';
import 'package:movies_app/app/data/providers/base_provider.dart';

import '../../core/utils/env_util.dart';
import '../../core/values/constants.dart';

class CastRepository {
  final BaseProvider<MovieActors> _provider;

  CastRepository(this._provider);

  Future<ProviderResponse<MovieActors?>> getMovieCast(int movieId)
    async => await _provider.findOne(
        path: '/movie/$movieId/credits',
        apiKey: await EnvUtil.get(Constants.apiKey),
        fromMap: MovieActors.fromMap,
        connectionTimeout: null,
        receiveTimeout: null,
      ); 
}