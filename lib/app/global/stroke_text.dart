import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/app/global/inner_shadow.dart';

class StrokeText extends StatelessWidget {
  final String text;
  final Color color;
  final Color? strokeColor;
  final double strokeWidth;
  final double? fontSize;
  final FontWeight? fontWeight;
  const StrokeText({
    super.key,
    required this.text,
    required this.color,
    this.strokeColor,
    this.strokeWidth = 3,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: GoogleFonts.montserrat(
            fontSize: fontSize,
            fontWeight: fontWeight,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor ?? Theme.of(context).colorScheme.primary,
          ),
        ),
        InnerShadow(
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.25),
              offset: Offset.fromDirection(1, 4),
              blurRadius: 4,
            )
          ],
          child: Text(
            text,
            style: GoogleFonts.montserrat(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: color,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: Offset.fromDirection(1, 4),
                    blurRadius: 4,
                  ),
                ]),
          ),
        ),
      ],
    );
  }
}
