import 'package:flutter/material.dart';
import 'package:movies_app/app/global/error_reload.dart';
import 'package:movies_app/app/views/home/states/movies_state.dart';

import '../../../core/utils/helpers.dart';
import '../../../global/skeleton_card.dart';
import '../../../global/stroke_text.dart';
import '../../details/details_screen.dart';

class TrendingMoviesWidget extends StatelessWidget {
  final MoviesState state;
  final VoidCallback? reload;
  const TrendingMoviesWidget({super.key, required this.state, this.reload});

  @override
  Widget build(BuildContext context) {
    if (state is LoadingMoviesState) {
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
    } else if (state is SuccessMoviesState) {
      return Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .4),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: (state as SuccessMoviesState).movies.length,
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: 20,
            );
          },
          itemBuilder: (context, index) {
            return Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) => DetailsScreen(
                              movieId: (state as SuccessMoviesState)
                                  .movies[index]
                                  .id,
                            )),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * .40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        Helpers.getImageUrl((state as SuccessMoviesState)
                            .movies[index]
                            .imgPath),
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
    } else if (state is ErrorMoviesState) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ErrorReload(
          errorMessage: (state as ErrorMoviesState).error.message,
          reload: reload,
        ),
      );
    }
    return Container();
  }
}
