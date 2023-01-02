import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonCard extends StatelessWidget {
  final BorderRadius? radius;
  final int shimmerDuration;
  final Color? cardColor;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  const SkeletonCard({
    super.key,
    this.radius,
    this.shimmerDuration = 1500,
    this.cardColor,
    this.height,
    this.width,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      borderRadius: radius ?? BorderRadius.circular(0),
      shimmerDuration: shimmerDuration,
      child: Container(
        decoration: BoxDecoration(
          color: cardColor ?? const Color.fromARGB(71, 128, 128, 128),
          borderRadius: radius,
        ),
        margin: margin,
        width: width,
        height: height,
      ),
    );
  }
}
