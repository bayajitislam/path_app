import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/core/constants/app_images.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/features/home/view/widgets/home_map_top_bar.dart';
import 'package:path_app/features/home/view/widgets/island_node_card.dart';
import 'package:path_app/features/base/controllers/base_controller.dart';
import 'package:path_app/routes/routes_name.dart';

/// Pixel-perfect celestial ocean map home page featuring 5 floating
/// glassmorphic island node cards (Rank, Stats, Friends, Score, Wallet)
/// with subtle organic floating levitation and staggered entrance animations.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _floatController;

  static const List<Interval> _entranceIntervals = [
    Interval(0.00, 0.45, curve: Curves.easeOutBack),
    Interval(0.12, 0.57, curve: Curves.easeOutBack),
    Interval(0.24, 0.69, curve: Curves.easeOutBack),
    Interval(0.36, 0.81, curve: Curves.easeOutBack),
    Interval(0.48, 1.00, curve: Curves.easeOutBack),
  ];

  @override
  void initState() {
    super.initState();
    // 1. Master entrance controller for cascading reveal
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 950),
    );

    // 2. Continuous ambient floating controller
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3800),
    );

    _entranceController.forward();
    _floatController.repeat();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  Widget _buildAnimatedIslandNode({
    required int index,
    required double phaseOffset,
    required Widget child,
  }) {
    final entranceAnim = CurvedAnimation(
      parent: _entranceController,
      curve: _entranceIntervals[index],
    );

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: Listenable.merge([entranceAnim, _floatController]),
        builder: (context, _) {
          // Desynchronized smooth sinusoidal bobbing (+/- 3.5 px)
          final floatVal = math.sin(
            _floatController.value * 2 * math.pi + phaseOffset,
          );
          final floatY = floatVal * 3.5;

          final scale = 0.88 + (0.12 * entranceAnim.value);
          final opacity = entranceAnim.value.clamp(0.0, 1.0);

          return Opacity(
            opacity: opacity,
            child: Transform.translate(
              offset: Offset(0, floatY),
              child: Transform.scale(scale: scale, child: child),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;

          return Stack(
            fit: StackFit.expand,
            children: [
              // 1. Full-screen Celestial Island Map Background
              Image.asset(
                AppImages.homeMapBg,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),

              // 2. Island Node 1: Rank (Top-Left Forest Island)
              Positioned(
                top: h * 0.211,
                left: w * 0.20,
                child: _buildAnimatedIslandNode(
                  index: 0,
                  phaseOffset: 0.0,
                  child: IslandNodeCard(
                    title: 'Rank',
                    iconPath: AppImages.rankIcon,
                    onTap: () {
                      if (Get.isRegistered<BaseController>()) {
                        Get.find<BaseController>().changeIndex(2);
                      } else {
                        Get.toNamed(RoutesName.leaderboard);
                      }
                    },
                  ),
                ),
              ),

              // 3. Island Node 2: Stats (Top-Right Sandy Island)
              Positioned(
                top: h * 0.295,
                right: w * 0.07,
                child: _buildAnimatedIslandNode(
                  index: 1,
                  phaseOffset: 0.4 * math.pi,
                  child: IslandNodeCard(
                    title: 'Stats',
                    iconPath: AppImages.statsIcon,
                    onTap: () => Get.toNamed(RoutesName.tripAnalytics),
                  ),
                ),
              ),

              // 4. Island Node 3: Friends (Center Lagoon Island)
              Positioned(
                top: h * 0.395,
                left: (w - 98.w) / 2,
                child: _buildAnimatedIslandNode(
                  index: 2,
                  phaseOffset: 0.8 * math.pi,
                  child: IslandNodeCard(
                    title: 'Friends',
                    iconPath: AppImages.friendsIcon,
                    onTap: () => Get.toNamed(RoutesName.friends),
                  ),
                ),
              ),

              // 5. Island Node 4: Score (Lower-Left Mountain Coast)
              Positioned(
                top: h * 0.54,
                left: w * 0.07,
                child: _buildAnimatedIslandNode(
                  index: 3,
                  phaseOffset: 1.2 * math.pi,
                  child: IslandNodeCard(
                    title: 'Score',
                    iconPath: AppImages.scoreIcon,
                    onTap: () => _showScoreDetails(context),
                  ),
                ),
              ),

              // 6. Island Node 5: Wallet (Lower-Right Mountain Coast)
              Positioned(
                top: h * 0.55,
                right: w * 0.07,
                child: _buildAnimatedIslandNode(
                  index: 4,
                  phaseOffset: 1.6 * math.pi,
                  child: IslandNodeCard(
                    title: 'Wallet',
                    iconPath: AppImages.walletIcon,
                    onTap: () => Get.toNamed(RoutesName.wallet),
                  ),
                ),
              ),

              // 7. Top App Bar (Logo on left, Leaf & Bell on right)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  bottom: false,
                  child: HomeMapTopBar(
                    onLeafTap: () => _showEcoScoreDetails(context),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showScoreDetails(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.r),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppPallete.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Your Driving Score',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A0E14),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              '84',
              style: GoogleFonts.inter(
                fontSize: 48.sp,
                fontWeight: FontWeight.w800,
                color: AppPallete.primary,
              ),
            ),
            Text(
              'Top 15% in your region',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: const Color(0xFF636363),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  void _showEcoScoreDetails(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.r),
        decoration: BoxDecoration(
          color: AppPallete.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.leaf, width: 24.w, height: 24.w),
                SizedBox(width: 8.w),
                Text(
                  'Eco Sustainability',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A0E14),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              '140 kg CO₂ Saved',
              style: GoogleFonts.inter(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: AppPallete.primary,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Keep maintaining eco-friendly routes to earn bonuses!',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: const Color(0xFF636363),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
