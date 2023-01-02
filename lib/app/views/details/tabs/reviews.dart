import 'package:flutter/material.dart';
import 'package:movies_app/app/global/comment.dart';

class ReviewsTab extends StatelessWidget {
  const ReviewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Comment(
          nickname: 'Iqbal Shafiq Rozaan',
          commentText:
              'From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government.',
        ),
        SizedBox(
          height: 20,
        ),
        Comment(
          nickname: 'Iqbal Shafiq Rozaan',
          commentText:
              'From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government.',
        ),
      ],
    );
  }
}
