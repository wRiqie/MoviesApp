import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: selectedTabIndex,
    );

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
                trendingMoviesWidget(state) ?? Container(),
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

  Widget? trendingMoviesWidget(MoviesState state) {
    if (state is LoadingMoviesState) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * .4,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SkeletonCard(
                radius: BorderRadius.circular(16),
                margin: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * .4,
              ),
              SkeletonCard(
                radius: BorderRadius.circular(16),
                margin: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * .4,
              ),
              SkeletonCard(
                radius: BorderRadius.circular(16),
                margin: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * .4,
              ),
              SkeletonCard(
                radius: BorderRadius.circular(16),
                margin: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * .4,
              ),
            ],
          ),
        ),
      );
    }
    if (state is SuccessMoviesState) {
      return Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .4),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: state.movies.length,
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: 20,
            );
          },
          itemBuilder: (context, index) {
            return Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) => DetailsScreen(
                              movieId: state.movies[index].id,
                            )),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * .40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        state.movies[index].imgUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                IgnorePointer(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: StrokeText(
                      text: "${index + 1}",
                      color: Theme.of(context).colorScheme.background,
                      fontSize: 96,
                      strokeWidth: 0.9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    }
    return null;
  }
}
