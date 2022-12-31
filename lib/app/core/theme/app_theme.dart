import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/app/core/theme/app_color_scheme.dart';
import 'package:movies_app/app/core/theme/app_colors.dart';

class AppTheme {
  final theme = ThemeData(
    colorScheme: appColorScheme,
    scaffoldBackgroundColor: appColorScheme.background,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.montserrat(
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: appColorScheme.background,
      selectedItemColor: appColorScheme.primary,
      unselectedItemColor: AppColors.grey,
    ),
    tabBarTheme: const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.label,
    ),
  );
}
