import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/theme/app_colors.dart';

class SearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  const SearchField({
    super.key,
    this.controller,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint ?? 'Search',
        hintStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: AppColors.grey,
        ),
        fillColor: AppColors.searchGrey,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        suffixIcon: const Icon(
          Icons.search,
          color: AppColors.grey,
        ),
      ),
    );
  }
}
