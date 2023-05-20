import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorReload extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback? reload;
  const ErrorReload({super.key, required this.errorMessage, this.reload});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: reload,
              icon: const Icon(
                Icons.loop,
                size: 36,
              ),
            ),
            Text(
              errorMessage ?? 'An error ocurred, please try again...',
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
      ),
    );
  }
}
