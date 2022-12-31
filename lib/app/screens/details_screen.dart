import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/app/core/theme/app_colors.dart';
import 'package:movies_app/app/core/utils/env_util.dart';
import 'package:movies_app/app/core/values/app_images.dart';
import 'package:movies_app/app/global/custom_tab_bar.dart';
import 'package:movies_app/app/screens/tabs/details/about.dart';
import 'package:movies_app/app/screens/tabs/details/cast.dart';
import 'package:movies_app/app/screens/tabs/details/reviews.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    List<String> tabs = [
      'About Movie',
      'Reviews',
      'Cast',
    ];

    List<Widget> tabViews = [
      const AboutTab(),
      const ReviewsTab(),
      const CastTab(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.bookmark,
              color: AppColors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      AppImages.poster,
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .3,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: const EdgeInsets.only(right: 10, bottom: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.panelGrey.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '9.5',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.asset(
                          AppImages.movieTwo,
                          width: 95,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .6,
                          child: Text(
                            'Spiderman No Way Home',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTagText(
                          text: '2021',
                          icon: AppImages.calendarIcon,
                        ),
                        _buildHorizontalSeparator(),
                        _buildTagText(
                          text: '148 Minutes',
                          icon: AppImages.clockIcon,
                        ),
                        _buildHorizontalSeparator(),
                        _buildTagText(
                          text: 'Action',
                          icon: AppImages.ticketIcon,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomTabBar(
                      tabs: tabs
                          .map((e) => Tab(
                                child: Text(
                                  e,
                                  style: GoogleFonts.poppins(
                                    fontWeight: tabs[0] == e
                                        ? FontWeight.w500
                                        : FontWeight.w400,
                                  ),
                                ),
                              ))
                          .toList(),
                      tabController: _tabController,
                      onTap: (value) {
                        setState(() {
                          _currentIndex = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    IndexedStack(
                      index: _currentIndex,
                      children: tabViews,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTagText({required String text, required String icon}) {
    return Row(
      children: [
        SvgPicture.asset(icon),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalSeparator() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: 1,
      height: 10,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }
}
