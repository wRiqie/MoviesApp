import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/app/core/utils/helpers.dart';
import 'package:movies_app/app/core/values/app_images.dart';

class Comment extends StatelessWidget {
  final String nickname;
  final String commentText;
  final double? rating;
  final String? photoPath;
  const Comment({
    super.key,
    required this.nickname,
    required this.commentText,
    required this.rating,
    required this.photoPath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              photoPath != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(
                        Helpers.getImageUrl(photoPath!),
                      ),
                      minRadius: 22,
                      maxRadius: 22,
                    )
                  : const CircleAvatar(
                      backgroundImage: AssetImage(
                        AppImages.profile,
                      ),
                      minRadius: 22,
                      maxRadius: 22,
                    ),
              const SizedBox(
                height: 14,
              ),
              rating != null
                  ? Text(
                      rating!.toStringAsFixed(1),
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary),
                    )
                  : Container(),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nickname,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                commentText,
                style: GoogleFonts.poppins(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
