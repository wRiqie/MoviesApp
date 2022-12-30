import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/app/core/values/app_images.dart';
import 'package:movies_app/app/screens/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _index = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ];

  void changeTab(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.homeIcon,
              width: 18,
              color: _index == 0
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.searchIcon,
              width: 18,
              color: _index == 1
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.bookmarkIcon,
              width: 16,
              color: _index == 2
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface,
            ),
            label: 'Watch List',
          ),
        ],
        currentIndex: _index,
        onTap: changeTab,
        selectedFontSize: 12,
      ),
      body: IndexedStack(
        index: _index,
        children: _pages,
      ),
    );
  }
}
