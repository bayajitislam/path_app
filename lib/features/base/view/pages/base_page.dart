import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';
import 'package:path_app/features/base/view/widgets/app_navbar.dart';
import 'package:path_app/features/home/view/pages/home_page.dart';
import 'package:path_app/features/leaderboard/view/pages/leaderboard_page.dart'
    show LeaderboardPage;
import 'package:path_app/features/log_route/view/pages/log_route_page.dart';
import 'package:path_app/features/profile/view/pages/profile_page.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  //Current Index
  int currentIndex = 0;

  //Pages
  List pages = [HomePage(), LogRoutePage(), LeaderboardPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.white,
      body: pages[currentIndex],

      //Floating Action Button
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: AppPallete.primary.withValues(alpha: 0.8),
        elevation: 1,
        onPressed: () {},
        child: Text(
          'Play',
          style: AppTextStyle.s12w4i(
            color: AppPallete.white,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //Bottom Navigation
      bottomNavigationBar: AppNavBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
    );
  }
}
