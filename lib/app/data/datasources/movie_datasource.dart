import '../models/movie_model.dart';

abstract class MovieDatasource {
  Future<List<MovieModel>> getTrendingWeek({int? page});
  Future<List<MovieModel>> getNowPlaying({int? page});
  Future<List<MovieModel>> getUpcoming({int? page});
  Future<List<MovieModel>> getTopRated({int? page});
  Future<List<MovieModel>> getPopular({int? page});
}