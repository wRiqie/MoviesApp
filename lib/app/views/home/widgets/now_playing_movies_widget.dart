import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/app/business_logic/blocs/movie_bloc.dart';
import 'package:movies_app/app/business_logic/blocs/movie_event.dart';
import 'package:movies_app/app/business_logic/blocs/movie_state.dart';
import 'package:movies_app/app/global/wrap_movies_placeholder_widget.dart';

import '../../../core/utils/helpers.dart';
import '../../../global/error_reload.dart';
import '../../details/details_screen.dart';

// TODO continuar criação das tabs da home

class NowPlayingMoviesWidget extends StatefulWidget {
  const NowPlayingMoviesWidget({super.key});

  @override
  State<NowPlayingMoviesWidget> createState() => _NowPlayingMoviesWidgetState();
}

class _NowPlayingMoviesWidgetState extends State<NowPlayingMoviesWidget> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MovieBloc>(context).add(MovieGetNowPlayingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Visibility(
              visible: state.status.isSuccess,
              child: InkWell(
                onTap: () {
                  if (state.status.isSuccess) {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => MovieListScreen<T>(),
                    //   ),
                    // );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 5,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'See more',
                        style: GoogleFonts.poppins(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
              if (state.status.isLoading) {
                return const WrapMoviesPlaceholderWidget();
              } else if (state.status.isSuccess) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Wrap(
                    spacing: 20,
                    alignment: WrapAlignment.start,
                    direction: Axis.horizontal,
                    runSpacing: 20,
                    children: state.nowPlayingMovies
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        DetailsScreen(movieId: e.id))),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                AppHelpers.getImageUrl(e.imgPath),
                                width: MediaQuery.of(context).size.width * .25,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ErrorReload(
                    errorMessage: state.error?.message,
                    reload: () {
                      BlocProvider.of<MovieBloc>(context)
                          .add(MovieGetNowPlayingEvent());
                    },
                  ),
                );
              }
            }),
          ],
        );
      },
    );
  }
}
