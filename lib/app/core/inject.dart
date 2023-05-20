import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_app/app/data/datasources/api/cast_datasource_api_imp.dart';
import 'package:movies_app/app/data/datasources/api/details_datasource_api_imp.dart';
import 'package:movies_app/app/data/datasources/api/movie_datasource_api_imp.dart';
import 'package:movies_app/app/data/datasources/api/reviews_datasource_api_imp.dart';
import 'package:movies_app/app/data/datasources/cast_datasource.dart';
import 'package:movies_app/app/data/datasources/details_datasource.dart';
import 'package:movies_app/app/data/datasources/movie_datasource.dart';
import 'package:movies_app/app/data/datasources/reviews_datasource.dart';
import 'package:movies_app/app/data/repositories/cast_respository.dart';
import 'package:movies_app/app/data/repositories/details_repository.dart';
import 'package:movies_app/app/data/repositories/movie_repository.dart';
import 'package:movies_app/app/data/repositories/reviews_repository.dart';
import 'package:movies_app/app/data/service/dio_http_service_imp.dart';
import 'package:movies_app/app/data/service/http_service.dart';

class Inject {
  static void init() {
    final getIt = GetIt.I;
    
    // services
    getIt.registerLazySingleton<HttpService>(() => DioHttpServiceImp(Dio()));

    // datasource
    getIt.registerLazySingleton<CastDatasource>(() => CastDatasourceApiImp(getIt()));
    getIt.registerLazySingleton<DetailsDatasource>(() => DetailsDatasourceApiImp(getIt()));
    getIt.registerLazySingleton<MovieDatasource>(() => MovieDatasourceApiImp(getIt()));
    getIt.registerLazySingleton<ReviewsDatasource>(() => ReviewsDatasourceApiImp(getIt()));

    // repository
    getIt.registerLazySingleton<CastRepository>(() => CastRepository(getIt()));
    getIt.registerLazySingleton<DetailsRepository>(() => DetailsRepository(getIt()));
    getIt.registerLazySingleton<MovieRepository>(() => MovieRepository(getIt()));
    getIt.registerLazySingleton<ReviewsRepository>(() => ReviewsRepository(getIt()));
  }
}