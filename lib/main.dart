import 'package:flutter/material.dart';
import 'package:movies_app/app/core/theme/app_theme.dart';
import 'package:movies_app/app/routes/app_pages.dart';
import 'package:movies_app/app/views/dashboard/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().theme,
      routes: AppPages.pages,
      initialRoute: AppRoutes.dashboard,
    );
  }
}
