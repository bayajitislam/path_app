import 'dart:ui';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/features/base/constants/navbar_images.dart';

class AppNavBar extends StatelessWidget {
  final int currentIndex;
  final dynamic Function(int) onTap;

  const AppNavBar({super.key, this.currentIndex = 0, required this.onTap});

  static const _images = [
    NavbarImages.home,
    NavbarImages.logRoute,
    NavbarImages.leaderboard,
    NavbarImages.profile,
  ];

  static const _labels = ['Home', 'Log Route', 'Leaderboard', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
      itemCount: 4,
      tabBuilder: (index, isActive) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            _images[index],
            width: 22,
            height: 22,
            color: isActive
                ? AppPallete.secondaryText
                : AppPallete.secondaryText,
          ),
          const SizedBox(height: 3),
          Text(
            _labels[index],
            style: TextStyle(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive
                  ? AppPallete.secondaryText
                  : AppPallete.secondaryText,
            ),
          ),
        ],
      ),
      activeIndex: currentIndex,
      gapLocation: GapLocation.center,
      backgroundColor: AppPallete.white.withValues(alpha: 0.6),
      notchSmoothness: NotchSmoothness.softEdge,
      blurEffect: true,
      imageFilter: ImageFilter.blur(
        sigmaX: 6.0,
        sigmaY: 6.0,
        tileMode: TileMode.decal,
      ),
      splashColor: AppPallete.primary.withValues(alpha: 0.1),
      safeAreaValues: SafeAreaValues(bottom: false, left: false, right: false),
      borderColor: AppPallete.border,
      onTap: onTap,
    );
  }
}
