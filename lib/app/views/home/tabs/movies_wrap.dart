import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/app/core/utils/helpers.dart';
import 'package:movies_app/app/global/error_reload.dart';
import 'package:movies_app/app/global/skeleton_card.dart';
import 'package:movies_app/app/views/details/details_screen.dart';
import 'package:movies_app/app/views/movie_list/movie_list_screen.dart';

class MoviesWrap extends StatefulWidget {
  final VoidCallback loadMovies;
  const MoviesWrap({
    super.key,
    required this.loadMovies,
  });

  @override
  State<MoviesWrap> createState() => _MoviesWrapState();
}

class _MoviesWrapState extends State<MoviesWrap> {
  @override
  void initState() {
    super.initState();
    widget.loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget>? children;

    if (state is LoadingMoviesState) {
      children = [
        SkeletonCard(
          radius: BorderRadius.circular(16),
          width: MediaQuery.of(context).size.width * .25,
          height: 150,
        ),
        SkeletonCard(
          radius: BorderRadius.circular(16),
          width: MediaQuery.of(context).size.width * .25,
          height: 150,
        ),
        SkeletonCard(
          radius: BorderRadius.circular(16),
          width: MediaQuery.of(context).size.width * .25,
          height: 150,
        ),
        SkeletonCard(
          radius: BorderRadius.circular(16),
          width: MediaQuery.of(context).size.width * .25,
          height: 150,
        ),
        SkeletonCard(
          radius: BorderRadius.circular(16),
          width: MediaQuery.of(context).size.width * .25,
          height: 150,
        ),
      ];
    }

    if (state is SuccessMoviesState) {
      children = state.movies
          .map(
            (e) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: ((context) => DetailsScreen(movieId: e.id))),
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
          .toList();
    }
    if (state is ErrorMoviesState) {
      children = [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ErrorReload(
            errorMessage: state.error.message,
            reload: context.read<T>().fetchAll,
          ),
        ),
      ];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Visibility(
          visible: state is SuccessMoviesState,
          child: InkWell(
            onTap: () {
              if (state is SuccessMoviesState) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MovieListScreen<T>(),
                  ),
                );
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Wrap(
            spacing: 20,
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            runSpacing: 20,
            children: children ?? [],
          ),
        ),
      ],
    );
  }
}
