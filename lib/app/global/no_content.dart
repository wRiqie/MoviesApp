import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/values/app_images.dart';

class NoContent extends StatelessWidget {
  final String title;
  final String label;
  final String? imagePath;
  final IconData? icon;
  final VoidCallback? onTap;
  const NoContent({
    super.key,
    required this.title,
    required this.label,
    this.imagePath,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * .6,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath ?? AppImages.noData,
              width: 60,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            icon != null ? IconButton(
              onPressed: onTap,
              icon: Icon(icon),
            ) : Container(),
          ],
        ),
      ),
    );
  }
}
