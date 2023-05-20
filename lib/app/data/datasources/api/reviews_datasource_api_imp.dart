import 'package:movies_app/app/data/datasources/reviews_datasource.dart';
import 'package:movies_app/app/data/models/extra_options_model.dart';
import 'package:movies_app/app/data/models/review_model.dart';
import 'package:movies_app/app/data/service/http_service.dart';

class ReviewsDatasourceApiImp implements ReviewsDatasource {
  final HttpService _httpService;

  ReviewsDatasourceApiImp(this._httpService);

  @override
  Future<List<ReviewModel>> getReviews(int movieId,
      {int? limit, int page = 1}) async {
    final response = await _httpService.get(
      '/movie/$movieId/reviews',
      options: ExtraOptionsModel(queryParameters: {
        'limit': limit,
        'page': page,
      }),
    );
    return response?.data['results'].isNotEmpty
        ? (response?.data['results'] as List)
            .map((e) => ReviewModel.fromMap(e))
            .toList()
        : [];
  }
}
