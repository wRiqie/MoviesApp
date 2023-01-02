import 'package:flutter/material.dart';
import 'package:movies_app/app/core/theme/app_theme.dart';
import 'package:movies_app/app/data/models/movie.dart';
import 'package:movies_app/app/data/models/movie_details.dart';
import 'package:movies_app/app/data/providers/api_provider.dart';
import 'package:movies_app/app/data/repositories/details_repository.dart';
import 'package:movies_app/app/data/repositories/movie_repository.dart';
import 'package:movies_app/app/views/dashboard/dashboard_screen.dart';
import 'package:movies_app/app/views/details/stores/details_store.dart';
import 'package:movies_app/app/views/home/stores/now_playing_movies_store.dart';
import 'package:movies_app/app/views/home/stores/popular_movies_store.dart';
import 'package:movies_app/app/views/home/stores/top_rated_movies_store.dart';
import 'package:movies_app/app/views/home/stores/trending_movies_store.dart';
import 'package:movies_app/app/views/home/stores/upcoming_movies_store.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _providers,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().theme,
        home: const DashboardScreen(),
      ),
    );
  }
}

final _providers = [
  Provider(create: (context) => ApiProvider<Movie>()),
  Provider(
      create: (context) => MovieRepository(context.read<ApiProvider<Movie>>())),
  ChangeNotifierProvider(
      create: ((context) => TrendingMoviesStore(context.read()))),
  ChangeNotifierProvider(
      create: ((context) => NowPlayingMoviesStore(context.read()))),
  ChangeNotifierProvider(
      create: ((context) => PopularMoviesStore(context.read()))),
  ChangeNotifierProvider(
      create: ((context) => TopRatedMoviesStore(context.read()))),
  ChangeNotifierProvider(
      create: ((context) => UpcomingMoviesStore(context.read()))),
  Provider(create: (context) => ApiProvider<MovieDetails>()),
  Provider(
      create: ((context) =>
          DetailsRepository(context.read<ApiProvider<MovieDetails>>()))),
  ChangeNotifierProvider(create: ((context) => DetailsStore(context.read()))),
];
