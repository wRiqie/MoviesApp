import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/app/business_logic/blocs/movie_bloc.dart';
import 'package:movies_app/app/business_logic/blocs/movie_event.dart';

import 'package:movies_app/app/global/custom_tab_bar.dart';
import 'package:movies_app/app/global/search_field.dart';
import 'package:movies_app/app/views/home/widgets/now_playing_movies_widget.dart';
import 'package:movies_app/app/views/home/widgets/trending_movies_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int selectedTabIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: selectedTabIndex,
    );

    BlocProvider.of<MovieBloc>(context).add(MovieGetTopRatedEvent());
  }

  List<Widget> tabViews = const [
    NowPlayingMoviesWidget(),
    // MoviesWrap<UpcomingMoviesStore>(),
    // MoviesWrap<TopRatedMoviesStore>(),
    // MoviesWrap<PopularMoviesStore>(),
  ];

  @override
  Widget build(BuildContext context) {
    List<String> tabs = [
      'Now playing',
      'Upcoming',
      'Top rated',
      'Popular',
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "What do you want to watch?",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const SearchField(),
                const SizedBox(
                  height: 18,
                ),
                const TrendingMoviesWidget(),
                CustomTabBar(
                  tabController: _tabController,
                  onTap: ((value) {
                    setState(() {
                      selectedTabIndex = value;
                    });
                  }),
                  tabs: tabs
                      .map((e) => Tab(
                            child: Text(
                              e,
                              style: GoogleFonts.poppins(
                                fontWeight: tabs[selectedTabIndex] == e
                                    ? FontWeight.w500
                                    : FontWeight.w400,
                              ),
                            ),
                          ))
                      .toList(),
                ),
                tabViews[selectedTabIndex],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
