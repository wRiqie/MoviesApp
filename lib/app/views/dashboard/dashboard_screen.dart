import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../core/values/app_images.dart';
import '../../global/no_content.dart';
import '../../global/states/network_state.dart';
import '../../global/stores/network_store.dart';
import '../home/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _index = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.blue,
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<NetworkStore>().checkConnection();
    });
  }

  void changeTab(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final networkstore = context.watch<NetworkStore>();
    final networkState = networkstore.value;

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
      body: Stack(
        children: [
          networkState is SuccessNetworkState
              ? IndexedStack(
                  index: _index,
                  children: _pages,
                )
              : NoContent(
                  title: 'No connection',
                  label: 'Try reloading by pressing the button below',
                  onTap: networkstore.checkConnection,
                  icon: Icons.loop,
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      ),
    );
  }
}
