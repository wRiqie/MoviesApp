import 'package:flutter/material.dart';
import 'package:movies_app/app/global/comment.dart';
import 'package:movies_app/app/views/details/states/reviews_state.dart';
import 'package:movies_app/app/views/details/stores/reviews_store.dart';
import 'package:provider/provider.dart';

import '../../../data/models/review_model.dart';

class ReviewsTab extends StatefulWidget {
  final int movieId;
  const ReviewsTab({super.key, required this.movieId});

  @override
  State<ReviewsTab> createState() => _ReviewsTabState();
}

class _ReviewsTabState extends State<ReviewsTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ReviewsStore>().fetchAll(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<ReviewsStore>();
    final state = store.value;

    if (state is LoadingReviewsState) {
      const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is SuccessReviewsState) {
      return Column(
        children: state.reviews
            .map((ReviewModel e) => Container(
              margin: const EdgeInsets.only(bottom: 32),
              child: Comment(
                    nickname: e.author,
                    commentText: e.content,
                    rating: e.rating,
                    photoPath: e.avatarPath,
                  ),
            ))
            .toList(),
      );
    }

    return Container();
  }
}
