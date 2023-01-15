import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/app/core/utils/helpers.dart';
import 'package:movies_app/app/global/skeleton_card.dart';
import 'package:movies_app/app/views/details/details_screen.dart';
import 'package:movies_app/app/views/home/states/movies_state.dart';
import 'package:movies_app/app/views/home/stores/movie_store.dart';
import 'package:provider/provider.dart';

class MoviesWrap<T extends MovieStore> extends StatefulWidget {
  const MoviesWrap({
    super.key,
  });

  @override
  State<MoviesWrap> createState() => _MoviesWrapState<T>();
}

class _MoviesWrapState<T extends MovieStore> extends State<MoviesWrap> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<T>().fetchAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<T>();
    final state = store.value;

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
                  Helpers.getImageUrl(e.imgPath),
                  width: MediaQuery.of(context).size.width * .25,
                ),
              ),
            ),
          )
          .toList();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
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
        Wrap(
          spacing: 20,
          alignment: WrapAlignment.start,
          direction: Axis.horizontal,
          runSpacing: 20,
          children: children ?? [],
        ),
      ],
    );
  }
}
