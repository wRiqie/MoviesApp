import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/app/business_logic/blocs/movie_bloc.dart';
import 'package:movies_app/app/business_logic/blocs/movie_event.dart';
import 'package:movies_app/app/business_logic/blocs/movie_state.dart';
import 'package:movies_app/app/global/error_reload.dart';

import '../../../core/utils/helpers.dart';
import '../../../global/skeleton_card.dart';
import '../../../global/stroke_text.dart';
import '../../details/details_screen.dart';

class TrendingMoviesWidget extends StatefulWidget {
  const TrendingMoviesWidget({super.key});

  @override
  State<TrendingMoviesWidget> createState() => _TrendingMoviesWidgetState();
}

class _TrendingMoviesWidgetState extends State<TrendingMoviesWidget> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MovieBloc>(context).add(MovieGetTrendingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .4,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SkeletonCard(
                    radius: BorderRadius.circular(16),
                    margin: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width * .4,
                  ),
                  SkeletonCard(
                    radius: BorderRadius.circular(16),
                    margin: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width * .4,
                  ),
                  SkeletonCard(
                    radius: BorderRadius.circular(16),
                    margin: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width * .4,
                  ),
                  SkeletonCard(
                    radius: BorderRadius.circular(16),
                    margin: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width * .4,
                  ),
                ],
              ),
            ),
          );
        } else if (state.status.isSuccess) {
          return Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * .4),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: state.trendingMovies.length,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 20,
                );
              },
              itemBuilder: (context, index) {
                final movie = state.trendingMovies[index];

                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) => DetailsScreen(movieId: movie.id)),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * .40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            AppHelpers.getImageUrl(
                                state.trendingMovies[index].imgPath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    IgnorePointer(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: StrokeText(
                          text: "${index + 1}",
                          color: Theme.of(context).colorScheme.background,
                          fontSize: 96,
                          strokeWidth: 0.9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ErrorReload(
              errorMessage: state.error?.message,
              reload: () {
                BlocProvider.of<MovieBloc>(context)
                    .add(MovieGetTrendingEvent());
              },
            ),
          );
        }
      },
    );
  }
}
