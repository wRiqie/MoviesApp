import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/app/business_logic/cubits/network/network_cubit.dart';
import 'package:movies_app/app/business_logic/cubits/network/network_state.dart';
import 'package:movies_app/app/core/values/app_images.dart';
import 'package:movies_app/app/views/home/home_screen.dart';

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
    BlocProvider.of<NetworkCubit>(context).checkConnection();
  }

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
      body: BlocBuilder<NetworkCubit, NetworkState>(
        builder: (context, state) {
          if (state.status.isConnected) {
            return IndexedStack(
              index: _index,
              children: _pages,
            );
          } else if (state.status.isDisconnected) {
            return Center(
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
                      'No connection',
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
                      'Try reloading by pressing the button below',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<NetworkCubit>(context)
                            .checkConnection();
                      },
                      icon: const Icon(Icons.loop),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
