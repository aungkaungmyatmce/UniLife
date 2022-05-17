import 'package:flutter/material.dart';

import '../../constant/app_colors.dart';

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  double height;

  SliverTabBarDelegate(
    this.tabBar, {
    this.height = 48,
  });

  final Widget? tabBar;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration:  const BoxDecoration(
          color: Colors.white,
            boxShadow: [
              BoxShadow(
                color:  AppColors.secondaryColor,
                blurRadius: 2,
              ),
            ]),
        child: tabBar,
      ),
    );
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return true;
  }
}