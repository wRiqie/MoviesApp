import 'package:flutter/material.dart';
import 'package:movies_app/app/global/skeleton_card.dart';

class WrapMoviesPlaceholderWidget extends StatelessWidget {
  const WrapMoviesPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        spacing: 20,
        alignment: WrapAlignment.start,
        direction: Axis.horizontal,
        runSpacing: 20,
        children: [
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
        ],
      ),
    );
  }
}
