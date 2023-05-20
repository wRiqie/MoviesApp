import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/app/core/theme/app_colors.dart';
import 'package:movies_app/app/core/utils/helpers.dart';
import 'package:movies_app/app/core/values/app_images.dart';
import 'package:movies_app/app/global/custom_tab_bar.dart';
import 'package:movies_app/app/views/details/states/details_state.dart';
import 'package:movies_app/app/views/details/stores/details_store.dart';
import 'package:movies_app/app/views/details/tabs/about.dart';
import 'package:movies_app/app/views/details/tabs/cast.dart';
import 'package:movies_app/app/views/details/tabs/reviews.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
    // required this.movieId,
  });

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DetailsStore>().fetchAll(widget.movieId);
    });
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
      ReviewsTab(movieId: widget.movieId),
      CastTab(movieId: widget.movieId),
    ];

    final store = context.watch<DetailsStore>();
    final state = store.value;

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
              backdropWidget(state),
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
                        voteAverageWidget(state),
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
                    posterTitleWidget(state),
                    const SizedBox(
                      height: 15,
                    ),
                    movieDetailsWidget(state),
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
                    tabViews[_currentIndex],
                  ],
                ),
              ),
              state is LoadingDetailsState
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.6),
                      child: Center(
                        child: Lottie.asset(AppImages.loading),
                      ),
                    )
                  : Container(),
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

  Widget backdropWidget(DetailsState state) {
    if (state is SuccessDetailsState) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .3,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              AppHelpers.getImageUrl(state.details.backdropPath),
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
      );
    }
    return Container();
  }

  Widget voteAverageWidget(DetailsState state) {
    if (state is SuccessDetailsState) {
      return Text(
        (state.details.voteAverage ?? 0.0).toStringAsFixed(1),
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: Theme.of(context).colorScheme.secondary,
        ),
      );
    }
    return Container();
  }

  Widget posterTitleWidget(DetailsState state) {
    if (state is SuccessDetailsState) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              AppHelpers.getImageUrl(state.details.posterPath),
              width: 95,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .6,
            child: Text(
              state.details.title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
          ),
        ],
      );
    }
    return Container();
  }

  Widget movieDetailsWidget(DetailsState state) {
    if (state is SuccessDetailsState) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTagText(
            text: state.details.releaseDateYear,
            icon: AppImages.calendarIcon,
          ),
          _buildHorizontalSeparator(),
          _buildTagText(
            text: '${state.details.runTime} Minutes',
            icon: AppImages.clockIcon,
          ),
          _buildHorizontalSeparator(),
          _buildTagText(
            text: state.details.genre,
            icon: AppImages.ticketIcon,
          ),
        ],
      );
    }
    return Container();
  }
}
