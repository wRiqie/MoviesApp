import 'package:movies_app/app/data/datasources/details_datasource.dart';
import 'package:movies_app/app/data/models/movie_details_model.dart';
import 'package:movies_app/app/data/service/http_service.dart';

class DetailsDatasourceApiImp implements DetailsDatasource {
  final HttpService _httpService;

  DetailsDatasourceApiImp(this._httpService);

  @override
  Future<MovieDetailsModel?> getDetails({required int movieId}) async {
    final response = await _httpService.get('/movie/$movieId');
    return response.data != null ? MovieDetailsModel.fromMap(response.data) : null;
  }
}
