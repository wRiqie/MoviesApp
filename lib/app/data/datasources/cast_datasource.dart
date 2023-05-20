import '../models/movie_actors_model.dart';

abstract class CastDatasource {
  Future<MovieActorsModel?> getMovieCast(int movieId);
}