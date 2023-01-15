import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/app/core/values/app_images.dart';
import 'package:movies_app/app/global/states/network_state.dart';
import 'package:movies_app/app/views/home/home_screen.dart';
import 'package:provider/provider.dart';

import '../../global/stores/network_store.dart';

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
      body: networkState is SuccessNetworkState
          ? IndexedStack(
              index: _index,
              children: _pages,
            )
          : Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .6,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      AppImages.noData,
                      width: 60,
                    ),
                    Text(
                      'There Is No Movie Yet',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Find your movie by Type title, categories, years, etc ',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        networkstore.checkConnection();
                      },
                      icon: const Icon(Icons.loop),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
