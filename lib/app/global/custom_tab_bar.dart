import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

class CustomTabBar extends StatelessWidget {
  final TabController tabController;
  final List<Tab> tabs;
  final Function(int)? onTap;
  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.tabController,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      isScrollable: true,
      indicatorWeight: 4,
      indicatorColor: AppColors.searchGrey,
      onTap: onTap,
      tabs: tabs,
    );
  }
}
