import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/core/constants/app_images.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/features/leaderboard/controllers/leaderboard_controller.dart';
import 'package:path_app/features/leaderboard/models/rank_tier_model.dart';
import 'package:path_app/features/leaderboard/view/pages/rank_detail_page.dart';
import 'package:path_app/features/leaderboard/view/widgets/cosmic_road_painter.dart';
import 'package:path_app/features/leaderboard/view/widgets/jackpot_tab_widgets.dart';
import 'package:path_app/features/leaderboard/view/widgets/leaderboard_tab_filter.dart';
import 'package:path_app/features/leaderboard/view/widgets/road_rank_node.dart';
import 'package:path_app/features/leaderboard/view/widgets/road_vehicle_marker.dart';
import 'package:path_app/routes/routes_name.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  int _mainTab = 0; // 0 = Career, 1 = Jackpot
  final ScrollController _scrollController = ScrollController();

  // Jackpot tab state
  bool _showRankReveal = false;
  int _jackpotPeriod = 0; // 0 = Weekly, 1 = Monthly

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<LeaderboardController>()
        ? Get.find<LeaderboardController>()
        : Get.put(LeaderboardController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── 1. Cosmic Starfield Wallpaper ────────────────────────
          Image.asset(AppImages.cosmicStarfieldBg, fit: BoxFit.cover),

          SafeArea(
            child: Column(
              children: [
                // ── 2. Top Header / App Bar ─────────────────────────
                _buildHeader(context),

                // ── 3. Main Tab Filter (Career / Jackpot) ───────────
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 6.h,
                  ),
                  child: LeaderboardTabFilter(
                    selectedIndex: _mainTab,
                    onChanged: (i) => setState(() {
                      _mainTab = i;
                      _showRankReveal = false;
                    }),
                  ),
                ),

                // ── 4. Tab Content ──────────────────────────────────
                Expanded(
                  child: ClipRect(
                    child: _mainTab == 0
                        ? _buildCareerRoadTab(context, controller)
                        : SingleChildScrollView(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            child: _buildJackpotTab(),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Custom top app bar matching the exact design screenshot
  Widget _buildHeader(BuildContext context) {
    final canPop = Navigator.of(context).canPop();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Back button & Title + Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    if (canPop)
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Padding(
                          padding: EdgeInsets.only(right: 6.w),
                          child: Icon(
                            Icons.chevron_left_rounded,
                            size: 26.r,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    Text(
                      'Career Leaderboard',
                      style: GoogleFonts.inter(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  'See how you rank against other drivers',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          // Notification Bell Button
          GestureDetector(
            onTap: () => Get.toNamed(RoutesName.notification),
            child: Container(
              width: 44.r,
              height: 44.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE8F5E9),
                border: Border.all(
                  color: AppPallete.primary.withValues(alpha: 0.7),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  AppImages.bell,
                  width: 22.r,
                  height: 22.r,
                  color: const Color(0xFF00C853),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Interactive Cosmic Road Career Progression Tab
  Widget _buildCareerRoadTab(
    BuildContext context,
    LeaderboardController controller,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;
        final roadHeight = math.max(h, 680.h);

        return SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: AnimatedBuilder(
            animation: _scrollController,
            builder: (context, _) {
              final scrollOffset = _scrollController.hasClients
                  ? _scrollController.offset
                  : 0.0;

              return SizedBox(
                width: w,
                height: roadHeight,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // ── 1. Cosmic Road Procedural Canvas ──
                    Positioned.fill(
                      child: CustomPaint(
                        painter: CosmicRoadPainter(
                          scrollOffset: scrollOffset,
                          viewportHeight: h,
                        ),
                      ),
                    ),

                    // ── 2. All 7 Rank Nodes following cosmic_road_painter vector coordinates ──
                    ..._buildRankProgression(
                      w,
                      roadHeight,
                      controller,
                      scrollOffset,
                      h,
                    ),

                    // ── 3. Driving Space Vehicle following road lane ──
                    _buildVehicleMarker(
                      w,
                      roadHeight,
                      controller,
                      scrollOffset,
                      h,
                    ),

                    // ── 4. Bottom-Left Space Car Switcher Button (Centered in Ring) ──
                    _buildCarSwitcherButton(
                      w,
                      roadHeight,
                      controller,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  /// Dynamic depth perspective zoom ("aste aste boro hoche")
  double _calculatePerspectiveScale({
    required double nodeY,
    required double scrollOffset,
    required double viewportHeight,
    required bool isCurrent,
  }) {
    if (viewportHeight <= 0) return isCurrent ? 1.15 : 1.0;

    final screenY = nodeY - scrollOffset;
    final eta = (screenY / viewportHeight).clamp(0.0, 1.0);

    final baseScale = 0.86 + 0.24 * eta;
    return isCurrent ? baseScale * 1.12 : baseScale;
  }

  /// All 7 Rank Nodes positioned using the exact Figma coordinates matching cosmic_road_painter.dart
  List<Widget> _buildRankProgression(
    double w,
    double roadHeight,
    LeaderboardController controller,
    double scrollOffset,
    double viewportHeight,
  ) {
    final tiers = RankTierModel.defaultTiers;

    // Exact Figma SVG coordinates (viewBox: 393 x 767) strictly following cosmic_road_painter.dart
    final nodeSpecs = [
      (tier: tiers[6], x: 169.5, y: 102.814), // Rank 7: Lion
      (tier: tiers[5], x: 114.5, y: 194.814), // Rank 6: Bear
      (tier: tiers[4], x: 54.5, y: 273.814),  // Rank 5: Shark
      (tier: tiers[3], x: 116.0, y: 351.314), // Rank 4: Dolphin (Current Active)
      (tier: tiers[2], x: 185.5, y: 433.814), // Rank 3: Small Fish
      (tier: tiers[1], x: 233.5, y: 516.814), // Rank 2: Phytoplankton
      (tier: tiers[0], x: 276.5, y: 605.814), // Rank 1: Garden
    ];

    return nodeSpecs.map((spec) {
      final top = roadHeight * (spec.y / 767.0);
      final left = w * (spec.x / 393.0);
      final scale = _calculatePerspectiveScale(
        nodeY: top,
        scrollOffset: scrollOffset,
        viewportHeight: viewportHeight,
        isCurrent: spec.tier.isCurrent,
      );

      return Positioned(
        top: top,
        left: left,
        child: Transform.scale(
          scale: scale,
          alignment: const Alignment(-0.6, 0.0),
          child: RoadRankNode(
            tier: spec.tier,
            onTap: () => _openRankDetail(spec.tier),
          ),
        ),
      );
    }).toList();
  }

  /// Space Vehicle driving along the highway lane
  Widget _buildVehicleMarker(
    double w,
    double roadHeight,
    LeaderboardController controller,
    double scrollOffset,
    double viewportHeight,
  ) {
    final top = roadHeight * (463.314 / 767.0);
    final left = w * (213.0 / 393.0);

    final scale = _calculatePerspectiveScale(
      nodeY: top,
      scrollOffset: scrollOffset,
      viewportHeight: viewportHeight,
      isCurrent: false,
    );

    return Positioned(
      top: top,
      left: left,
      child: Transform.scale(
        scale: scale,
        alignment: Alignment.center,
        child: RoadVehicleMarker(
          carId: controller.selectedCarId.value,
          onTap: () => Get.toNamed(RoutesName.selectSpaceCar),
        ),
      ),
    );
  }

  /// Bottom-Left Space Car Switcher Button (Centered in dashed guideline ring)
  Widget _buildCarSwitcherButton(
    double w,
    double roadHeight,
    LeaderboardController controller,
  ) {
    return Positioned(
      left: w * (32.5 / 393.0),
      top: roadHeight * (592.814 / 767.0),
      child: GestureDetector(
        onTap: () => Get.toNamed(RoutesName.selectSpaceCar),
        child: Container(
          width: 63.r,
          height: 63.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.22),
              width: 1,
            ),
          ),
          child: Center(
            child: Container(
              width: 50.r,
              height: 50.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF0F172A).withValues(alpha: 0.92),
                border: Border.all(
                  color: const Color(0xFF64748B),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8B5CF6).withValues(alpha: 0.35),
                    blurRadius: 14,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(7.r),
                  child: Image.asset(
                    AppImages.purpleHoverCar,
                    width: 36.r,
                    height: 24.r,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openRankDetail(RankTierModel tier) {
    Get.to(
      () => RankDetailPage(tier: tier),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 300),
    );
  }

  /// Jackpot Tab Content
  Widget _buildJackpotTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pot stats
        const JackpotPotStatsCard(totalPot: 250, prizePool: 19, winners: 0),
        SizedBox(height: 12.h),

        if (!_showRankReveal) ...[
          // Congrats card — tap to reveal rank
          JackpotCongratsCard(
            points: 985,
            percentage: 99,
            topPercent: '18%',
            estimatedReward: 65,
            eligibleTo: const ['Weekly Jackpot', 'Monthly Jackpot'],
            nextUnlock: 'Need only 2 more eco trips',
            onTap: () => setState(() => _showRankReveal = true),
          ),
        ] else ...[
          // Weekly / Monthly toggle
          _JackpotPeriodToggle(
            selectedIndex: _jackpotPeriod,
            onChanged: (i) => setState(() => _jackpotPeriod = i),
          ),
          SizedBox(height: 16.h),

          // Confetti bg + rank card
          Stack(
            children: [
              // Confetti behind
              ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: SizedBox(
                  height: 220.h,
                  child: CustomPaint(
                    size: Size(double.infinity, 220.h),
                    painter: _ConfettiBgPainter(),
                  ),
                ),
              ),
              // Rank card on top
              Padding(
                padding: EdgeInsets.only(top: 60.h),
                child: const JackpotRankRevealCard(rank: 36, topPercent: '18%'),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

// ─── Jackpot Period Toggle ────────────────────────────────────────────────────

class _JackpotPeriodToggle extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onChanged;

  const _JackpotPeriodToggle({required this.selectedIndex, this.onChanged});

  static const _tabs = ['Weekly', 'Monthly'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_tabs.length, (i) {
        final isSelected = i == selectedIndex;
        return GestureDetector(
          onTap: () => onChanged?.call(i),
          child: Padding(
            padding: EdgeInsets.only(right: i < _tabs.length - 1 ? 20.w : 0),
            child: Column(
              children: [
                Text(
                  _tabs[i],
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                    color: isSelected ? Colors.white : Colors.white60,
                  ),
                ),
                SizedBox(height: 4.h),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 2.h,
                  width: isSelected ? 28.w : 0,
                  decoration: BoxDecoration(
                    color: const Color(0xFF00E5FF),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

// ─── Confetti Background Painter ─────────────────────────────────────────────

class _ConfettiBgPainter extends CustomPainter {
  static const _colors = [
    Color(0xFFFF6B6B),
    Color(0xFFFFD93D),
    Color(0xFF6BCB77),
    Color(0xFF4D96FF),
    Color(0xFFFF6BB5),
    Color(0xFF00C9A7),
    Color(0xFFFF922B),
  ];

  static const _pieces = [
    (0.1, 0.1, 12.0, 6.0, 0.3, 0),
    (0.2, 0.3, 8.0, 5.0, -0.5, 1),
    (0.35, 0.05, 14.0, 7.0, 0.8, 2),
    (0.5, 0.2, 10.0, 5.0, -0.2, 3),
    (0.65, 0.08, 8.0, 6.0, 0.6, 4),
    (0.8, 0.25, 12.0, 5.0, -0.4, 5),
    (0.9, 0.12, 9.0, 7.0, 0.9, 6),
    (0.15, 0.45, 7.0, 5.0, 0.3, 0),
    (0.45, 0.4, 11.0, 6.0, -0.7, 1),
    (0.75, 0.42, 9.0, 5.0, 0.5, 2),
    (0.05, 0.6, 8.0, 6.0, -0.3, 3),
    (0.3, 0.55, 10.0, 7.0, 0.6, 4),
    (0.6, 0.5, 12.0, 5.0, -0.4, 5),
    (0.88, 0.6, 8.0, 6.0, 0.7, 6),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in _pieces) {
      final paint = Paint()..color = _colors[p.$6].withValues(alpha: 0.85);
      canvas.save();
      canvas.translate(p.$1 * size.width, p.$2 * size.height);
      canvas.rotate(p.$5);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset.zero, width: p.$3, height: p.$4),
          const Radius.circular(2),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}
