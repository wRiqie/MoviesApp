import '../models/movie_details_model.dart';

abstract class DetailsDatasource {
  Future<MovieDetailsModel?> getDetails({required int movieId});
}