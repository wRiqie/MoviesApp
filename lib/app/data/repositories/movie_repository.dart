import 'package:movies_app/app/core/customTypes/error_func.dart';
import 'package:movies_app/app/core/utils/env_util.dart';
import 'package:movies_app/app/core/values/constants.dart';
import 'package:movies_app/app/data/models/movie.dart';
import 'package:movies_app/app/data/providers/base_provider.dart';

class MovieRepository {
  final BaseProvider<Movie> _provider;
  MovieRepository(this._provider);

  Future<List<Movie>> getTrendingWeek({int limit = 4, ErrorFunc? onError}) async => await _provider.get(
        path: '/trending/movie/week',
        apiKey: await EnvUtil.get(Constants.apiKey),
        page: 1,
        fromMap: Movie.fromMap,
        connectionTimeout: null,
        receiveTimeout: null,
        limit: limit,
        onError: onError,
      );

  Future<List<Movie>> getNowPlaying({int limit = 6, ErrorFunc? onError}) async => await _provider.get(
        path: '/movie/now_playing',
        apiKey: await EnvUtil.get(Constants.apiKey),
        fromMap: Movie.fromMap,
        connectionTimeout: null,
        receiveTimeout: null,
        limit: limit,
        onError: onError,
      );

  Future<List<Movie>> getUpcoming({int limit = 6, ErrorFunc? onError}) async => await _provider.get(
        path: '/movie/upcoming',
        apiKey: await EnvUtil.get(Constants.apiKey),
        fromMap: Movie.fromMap,
        connectionTimeout: null,
        receiveTimeout: null,
        limit: limit,
        onError: onError,
      );

  Future<List<Movie>> getTopRated({int limit = 6, ErrorFunc? onError}) async => await _provider.get(
        path: '/movie/top_rated',
        apiKey: await EnvUtil.get(Constants.apiKey),
        fromMap: Movie.fromMap,
        connectionTimeout: null,
        receiveTimeout: null,
        limit: limit,
        onError: onError,
      );

  Future<List<Movie>> getPopular({int limit = 6, ErrorFunc? onError}) async => await _provider.get(
        path: '/movie/popular',
        apiKey: await EnvUtil.get(Constants.apiKey),
        fromMap: Movie.fromMap,
        connectionTimeout: null,
        receiveTimeout: null,
        limit: limit,
        onError: onError,
      );
}
