import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_app/features/base/controllers/base_controller.dart';
import 'package:path_app/features/base/view/widgets/app_navbar.dart';
import 'package:path_app/features/home/view/pages/home_page.dart';
import 'package:path_app/features/leaderboard/view/pages/leaderboard_page.dart'
    show LeaderboardPage;
import 'package:path_app/features/log_route/view/pages/log_route_page.dart';
import 'package:path_app/features/play/view/pages/play_page.dart';
import 'package:path_app/features/profile/view/pages/profile_page.dart';

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

        // Floating Action Button with Cyan-Green Gradient & Gamepad Icon
        floatingActionButton: Container(
          width: 60.r,
          height: 60.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF1EBFBA), Color(0xFF27AE60)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () => controller.changeIndex(4),
              child: Center(
                child: Image.asset(
                  'assets/icons/stats.png',
                  width: 28.r,
                  height: 28.r,
                  // color: Colors.white,
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
