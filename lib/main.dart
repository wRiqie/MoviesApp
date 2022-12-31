import 'package:flutter/material.dart';
import 'package:movies_app/app/core/theme/app_theme.dart';
import 'package:movies_app/app/screens/dashboard_screen.dart';
import 'package:movies_app/app/screens/details_screen.dart';
import 'package:movies_app/app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().theme,
      home: const DashboardScreen(),
    );
  }
}