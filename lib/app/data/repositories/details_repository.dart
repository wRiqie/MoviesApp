import 'package:movies_app/app/data/datasources/details_datasource.dart';
import 'package:movies_app/app/data/models/default_response_model.dart';
import 'package:movies_app/app/data/models/movie_details_model.dart';
import 'package:movies_app/app/data/service/execute_service.dart';

class DetailsRepository {
  final DetailsDatasource _detailsDatasource;

  DetailsRepository(this._detailsDatasource);

  Future<DefaultResponseModel<MovieDetailsModel?>> getDetails(int movieId) {
    return ExecuteService.tryExecuteAsync(
        execute: () => _detailsDatasource.getDetails(movieId: movieId));
  }
}
