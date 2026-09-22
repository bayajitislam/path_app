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

  static const _labels = ['Dashboard', 'Log Route', 'Leaderboard', 'Profile'];

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
            color: isActive ? const Color(0xFF111827) : const Color(0xFF6B7280),
          ),
          const SizedBox(height: 3),
          Text(
            _labels[index],
            style: TextStyle(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive
                  ? const Color(0xFF111827)
                  : const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
      activeIndex: currentIndex,
      gapLocation: GapLocation.center,
      backgroundColor: AppPallete.white.withValues(alpha: 0.95),
      notchSmoothness: NotchSmoothness.softEdge,
      blurEffect: true,
      imageFilter: ImageFilter.blur(
        sigmaX: 8.0,
        sigmaY: 8.0,
        tileMode: TileMode.decal,
      ),
      splashColor: AppPallete.primary.withValues(alpha: 0.1),
      safeAreaValues: const SafeAreaValues(
        bottom: false,
        left: false,
        right: false,
      ),
      borderColor: const Color(0xFFE5E7EB),
      onTap: onTap,
    );
  }
}
