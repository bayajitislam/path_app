import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_app/features/base/constants/navbar_images.dart';
import 'package:path_app/features/base/controllers/base_controller.dart';
import 'package:path_app/features/base/view/widgets/app_navbar.dart';
import 'package:path_app/features/home/view/pages/home_page.dart';
import 'package:path_app/features/leaderboard/view/pages/leaderboard_page.dart'
    show LeaderboardPage;
import 'package:path_app/features/log_route/view/pages/log_route_page.dart';
import 'package:path_app/features/play/view/pages/play_page.dart';
import 'package:path_app/features/profile/view/pages/profile_page.dart';
import 'dart:ui';

class BasePage extends StatelessWidget {
  const BasePage({super.key});

  static const List<Widget> pages = [
    HomePage(),
    LogRoutePage(),
    LeaderboardPage(),
    ProfilePage(),
    PlayPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BaseController());

    return Obx(
      () => Scaffold(
        extendBody: true,
        body: pages[controller.currentIndex.value],

        // Glassmorphic Floating Action Button (Play)
        floatingActionButton: Container(
          width: 62.r,
          height: 62.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1EBFBA).withValues(alpha: 0.35),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 22,
                sigmaY: 22,
              ), // Proper blur filter
              child: Container(
                width: 62.r,
                height: 62.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [const Color(0xff4AB9E6), const Color(0xff34C759)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  border: Border.all(
                    color: Colors.white.withValues(
                      alpha: 0.65,
                    ), // Specular glass edge
                    width: 0.22,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => controller.changeIndex(4),
                    child: Center(
                      child: Image.asset(
                        NavbarImages.play,
                        width: 28.r,
                        height: 28.r,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        // Bottom Navigation
        bottomNavigationBar: AppNavBar(
          currentIndex: controller.currentIndex.value,
          onTap: (value) => controller.changeIndex(value),
        ),
      ),
    );
  }
}
