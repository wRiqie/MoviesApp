import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/app/core/theme/app_colors.dart';
import 'package:movies_app/app/core/values/app_images.dart';
import 'package:movies_app/app/global/search_field.dart';
import 'package:movies_app/app/global/stroke_text.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    List<String> movies = [
      AppImages.movieOne,
      AppImages.movieTwo,
      AppImages.movieThree,
      AppImages.movieFour,
    ];

    List<String> tabs = [
      'Now playing',
      'Upcoming',
      'Top rated',
      'Popular',
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
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
                Container(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * .4),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 20,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Image.asset(
                            movies[index],
                            width: MediaQuery.of(context).size.width * .4,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: StrokeText(
                              text: "${index + 1}",
                              color: Theme.of(context).colorScheme.background,
                              fontSize: 96,
                              strokeWidth: 0.9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 4,
                  indicatorColor: AppColors.searchGrey,
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
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  direction: Axis.horizontal,
                  runSpacing: 20,
                  children: movies
                      .map(
                        (e) => Image.asset(
                          e,
                          width: MediaQuery.of(context).size.width * .25,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
