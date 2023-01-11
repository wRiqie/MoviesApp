import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/app/core/utils/helpers.dart';
import 'package:movies_app/app/data/models/movie.dart';
import 'package:movies_app/app/data/providers/api_provider.dart';
import 'package:movies_app/app/data/repositories/movie_repository.dart';

import 'package:movies_app/app/global/custom_tab_bar.dart';
import 'package:movies_app/app/global/search_field.dart';
import 'package:movies_app/app/global/skeleton_card.dart';
import 'package:movies_app/app/global/stroke_text.dart';
import 'package:movies_app/app/views/details/details_screen.dart';
import 'package:movies_app/app/views/home/bloc/movie_event.dart';
import 'package:movies_app/app/views/home/bloc/movie_state.dart';
import 'package:movies_app/app/views/home/tabs/movies_wrap.dart';

import 'bloc/movie_bloc.dart';

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

  late final MovieBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = MovieBloc(MovieRepository(ApiProvider<Movie>()));
    bloc.inputMovie.add(LoadTrendingMoviesEvent());

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
  }
  
  @override
  void dispose() {
    bloc.inputMovie.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> tabs = [
      'Now playing',
      'Upcoming',
      'Top rated',
      'Popular',
    ];

    List<Widget> tabViews = [
      MoviesWrap(loadEvent: LoadNowPlayingMoviesEvent()),
      MoviesWrap(loadEvent: LoadUpcomingMoviesEvent()),
      MoviesWrap(loadEvent: LoadTopRatedMoviesEvent()),
      MoviesWrap(loadEvent: LoadPopularMoviesEvent()),
      // Container(color: Colors.red, width: 100, height: 100,),
      // Container(color: Colors.green, width: 100, height: 100,),
      // Container(color: Colors.blue, width: 100, height: 100,),
      // Container(color: Colors.black, width: 100, height: 100,),
    ];

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
                StreamBuilder(
                  stream: bloc.stream,
                  builder: (context, snapshot) => snapshot.data != null
                      ? (trendingMoviesWidget(snapshot.data!) ?? Container())
                      : Container(),
                ),
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

  Widget? trendingMoviesWidget(MovieState state) {
    if (state is LoadingMovieState) {
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
    if (state is SuccessMovieState) {
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
                        Helpers.getImageUrl(state.movies[index].imgPath),
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
