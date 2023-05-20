import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_app/app/business_logic/blocs/movie_bloc.dart';
import 'package:movies_app/app/business_logic/cubits/network/network_cubit.dart';
import 'package:movies_app/app/views/dashboard/dashboard_screen.dart';
import 'package:movies_app/app/views/details/details_screen.dart';
import 'package:movies_app/app/views/home/home_screen.dart';

part 'app_routes.dart';

class AppPages {
  static final pages = {
    AppRoutes.dashboard: (BuildContext context) => BlocProvider(
          create: (context) => NetworkCubit(),
          child: const DashboardScreen(),
        ),
    AppRoutes.home: (BuildContext context) => BlocProvider(
          create: (context) => MovieBloc(GetIt.I()),
          child: const HomeScreen(),
        ),
    AppRoutes.details: (BuildContext context) =>  const DetailsScreen(),
  };
}
