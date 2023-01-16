import 'package:movies_app/app/data/models/movie_details.dart';
import 'package:movies_app/app/data/models/provider_response.dart';

import '../../core/utils/env_util.dart';
import '../../core/values/constants.dart';
import '../providers/base_provider.dart';

class DetailsRepository {
  final BaseProvider<MovieDetails> _provider;
  DetailsRepository(this._provider);

  Future<ProviderResponse<MovieDetails?>> getDetails({required int movieId}) async =>
      await _provider.findOne(
        path: '/movie/$movieId',
        apiKey: await EnvUtil.get(Constants.apiKey),
        fromMap: MovieDetails.fromMap,
        connectionTimeout: null,
        receiveTimeout: null,
      );
}
