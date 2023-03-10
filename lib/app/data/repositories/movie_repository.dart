import 'package:movies_app/app/core/utils/env_util.dart';
import 'package:movies_app/app/core/values/constants.dart';
import 'package:movies_app/app/data/models/movie.dart';
import 'package:movies_app/app/data/providers/base_provider.dart';

import '../models/provider_response.dart';

class MovieRepository {
  final BaseProvider<Movie> _provider;
  MovieRepository(this._provider);

  Future<ProviderResponse<List<Movie>>> getTrendingWeek({int? limit, int? page}) async => await _provider.get(
        path: '/trending/movie/week',
        apiKey: await EnvUtil.get(Constants.apiKey),
        page: 1,
        fromMap: Movie.fromMap,
        connectionTimeout: null,
        receiveTimeout: null,
        limit: limit ?? 4,
      );

  Future<ProviderResponse<List<Movie>>> getNowPlaying({int? limit, int? page}) async => await _provider.get(
        path: '/movie/now_playing',
        apiKey: await EnvUtil.get(Constants.apiKey),
        fromMap: Movie.fromMap,
        connectionTimeout: null,
        receiveTimeout: null,
        limit: limit ?? 6,
      );

  Future<ProviderResponse<List<Movie>>> getUpcoming({int? limit, int? page}) async => await _provider.get(
        path: '/movie/upcoming',
        apiKey: await EnvUtil.get(Constants.apiKey),
        fromMap: Movie.fromMap,
        connectionTimeout: null,
        receiveTimeout: null,
        limit: limit ?? 6,
      );

  Future<ProviderResponse<List<Movie>>> getTopRated({int? limit, int? page}) async => await _provider.get(
        path: '/movie/top_rated',
        apiKey: await EnvUtil.get(Constants.apiKey),
        fromMap: Movie.fromMap,
        connectionTimeout: null,
        receiveTimeout: null,
        limit: limit ?? 6,
      );

  Future<ProviderResponse<List<Movie>>> getPopular({int? limit, int? page}) async => await _provider.get(
        path: '/movie/popular',
        apiKey: await EnvUtil.get(Constants.apiKey),
        fromMap: Movie.fromMap,
        connectionTimeout: null,
        receiveTimeout: null,
        limit: limit ?? 6,
      );
}
