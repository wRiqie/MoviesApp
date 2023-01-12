import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/app/core/utils/helpers.dart';

import 'package:movies_app/app/global/custom_tab_bar.dart';
import 'package:movies_app/app/global/search_field.dart';
import 'package:movies_app/app/global/skeleton_card.dart';
import 'package:movies_app/app/global/stroke_text.dart';
import 'package:movies_app/app/views/details/details_screen.dart';
import 'package:movies_app/app/views/home/states/movies_state.dart';
import 'package:movies_app/app/views/home/stores/now_playing_movies_store.dart';
import 'package:movies_app/app/views/home/stores/popular_movies_store.dart';
import 'package:movies_app/app/views/home/stores/top_rated_movies_store.dart';
import 'package:movies_app/app/views/home/stores/trending_movies_store.dart';
import 'package:movies_app/app/views/home/stores/upcoming_movies_store.dart';
import 'package:movies_app/app/views/home/tabs/movies_wrap.dart';
import 'package:movies_app/app/views/home/widgets/trending_movies.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int selectedTabIndex = 0;
  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: selectedTabIndex,
    );
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (kDebugMode) {
        print(_scrollController.offset);
      }
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent) {
        if (kDebugMode) {
          print("Chegou ao fim");
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<TrendingMoviesStore>().fetchAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> tabs = [
      'Now playing',
      'Upcoming',
      'Top rated',
      'Popular',
    ];

    List<Widget> tabViews = const [
      MoviesWrap<NowPlayingMoviesStore>(),
      MoviesWrap<UpcomingMoviesStore>(),
      MoviesWrap<TopRatedMoviesStore>(),
      MoviesWrap<PopularMoviesStore>(),
    ];

    final store = context.watch<TrendingMoviesStore>();
    final state = store.value;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
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
                TrendingMoviesWidget(state: state),
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
                const SizedBox(
                  height: 20,
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
