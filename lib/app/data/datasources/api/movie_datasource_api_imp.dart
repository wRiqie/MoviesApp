import 'package:movies_app/app/data/datasources/movie_datasource.dart';
import 'package:movies_app/app/data/models/extra_options_model.dart';
import 'package:movies_app/app/data/models/movie_model.dart';
import 'package:movies_app/app/data/service/http_service.dart';

class MovieDatasourceApiImp implements MovieDatasource {
  final HttpService _httpService;

  MovieDatasourceApiImp(this._httpService);

  @override
  Future<List<MovieModel>> getNowPlaying({int? page}) async {
    final response = await _httpService.get('/movie/now_playing',
        options: ExtraOptionsModel(queryParameters: {
          'page': page,
        }));
    return response?.data['results'].isNotEmpty
        ? (response?.data['results'] as List)
            .map((e) => MovieModel.fromMap(e))
            .toList()
        : [];
  }

  @override
  Future<List<MovieModel>> getPopular({int? page}) async {
    final response = await _httpService.get('/movie/popular',
        options: ExtraOptionsModel(queryParameters: {
          'page': page,
        }));
    return response?.data['results'].isNotEmpty
        ? (response?.data['results'] as List)
            .map((e) => MovieModel.fromMap(e))
            .toList()
        : [];
  }

  @override
  Future<List<MovieModel>> getTopRated({int? page}) async {
    final response = await _httpService.get('/movie/top_rated',
        options: ExtraOptionsModel(queryParameters: {
          'page': page,
        }));
    return response?.data['results'].isNotEmpty
        ? (response?.data['results'] as List)
            .map((e) => MovieModel.fromMap(e))
            .toList()
        : [];
  }

  @override
  Future<List<MovieModel>> getTrendingWeek({int? page}) async {
    final response = await _httpService.get('/trending/movie/week',
        options: ExtraOptionsModel(queryParameters: {
          'page': page,
        }));
    return response?.data['results'].isNotEmpty
        ? (response?.data['results'] as List)
            .map((e) => MovieModel.fromMap(e))
            .toList()
        : [];
  }

  @override
  Future<List<MovieModel>> getUpcoming({int? page}) async {
    final response = await _httpService.get('/movie/upcoming',
        options: ExtraOptionsModel(queryParameters: {
          'page': page,
        }));
    return response?.data['results'].isNotEmpty
        ? (response?.data['results'] as List)
            .map((e) => MovieModel.fromMap(e))
            .toList()
        : [];
  }
}
