import 'package:flutter/material.dart';
import 'package:movies_app/app/core/utils/helpers.dart';
import 'package:movies_app/app/data/providers/api_provider.dart';
import 'package:movies_app/app/data/repositories/movie_repository.dart';
import 'package:movies_app/app/global/skeleton_card.dart';
import 'package:movies_app/app/views/details/details_screen.dart';
import 'package:movies_app/app/views/home/bloc/movie_event.dart';
import 'package:movies_app/app/views/home/bloc/movie_state.dart';

import '../bloc/movie_bloc.dart';

class MoviesWrap extends StatefulWidget {
  final MovieEvent loadEvent;
  const MoviesWrap({
    super.key,
    required this.loadEvent,
  });

  @override
  State<MoviesWrap> createState() => _MoviesWrapState();
}

class _MoviesWrapState extends State<MoviesWrap> {
  late MovieBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = MovieBloc(MovieRepository(ApiProvider()));
    bloc.inputMovie.add(widget.loadEvent);
  }

  @override
  void dispose() {
    bloc.inputMovie.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.stream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        List<Widget>? children;
        if (state is LoadingMovieState) {
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

        if (state is SuccessMovieState) {
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

        return Wrap(
          spacing: 20,
          alignment: WrapAlignment.start,
          direction: Axis.horizontal,
          runSpacing: 20,
          children: children ?? [],
        );
      },
    );
  }
}
