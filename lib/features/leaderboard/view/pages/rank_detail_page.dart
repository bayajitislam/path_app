import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/core/widgets/primary_button.dart';
import 'package:path_app/core/widgets/secondary_app_bar.dart';
import 'package:path_app/features/leaderboard/controllers/leaderboard_controller.dart';
import 'package:path_app/features/leaderboard/models/rank_tier_model.dart';
import 'package:path_app/features/leaderboard/view/widgets/radial_gauge_painter.dart';

/// Screen displaying the active tier details, radial gauge arc, benefits, and promotion guide.
class RankDetailPage extends StatefulWidget {
  final RankTierModel? tier;

  const RankDetailPage({super.key, this.tier});

  @override
  State<RankDetailPage> createState() => _RankDetailPageState();
}

class _RankDetailPageState extends State<RankDetailPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _gaugeCtrl;
  late final Animation<double> _gaugeAnim;

  @override
  void initState() {
    super.initState();
    _gaugeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _gaugeAnim = CurvedAnimation(
      parent: _gaugeCtrl,
      curve: Curves.easeOutCubic,
    );
    _gaugeCtrl.forward();
  }

  @override
  void dispose() {
    _gaugeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<LeaderboardController>()
        ? Get.find<LeaderboardController>()
        : Get.put(LeaderboardController());

    final activeTier = widget.tier ??
        (Get.arguments is RankTierModel
            ? Get.arguments as RankTierModel
            : controller.activeTier);
    final nextTier = RankTierModel.defaultTiers.firstWhere(
      (t) => t.rank == activeTier.rank + 1,
      orElse: () => activeTier,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Stack(
        children: [
          // Subtle soft greenish ambient gradient in background
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFE8F5E9),
                    Color(0xFFE0F7FA),
                    Color(0xFFFFFFFF),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.35, 0.7],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Top App Bar
                SecondaryAppBar(
                  title: activeTier.name,
                ),

                // Scrollable Body
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1. Semi-Circular Radial Gauge Card
                        Center(
                          child: SizedBox(
                            width: 280.w,
                            height: 160.h,
                            child: AnimatedBuilder(
                              animation: _gaugeAnim,
                              builder: (context, _) => CustomPaint(
                                painter: RadialGaugePainter(
                                  progress: 0.85 * _gaugeAnim.value,
                                  strokeWidth: 16.0,
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                      bottom: 6.h,
                                      left: 14.w,
                                      child: Text(
                                        '0',
                                        style: GoogleFonts.inter(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF6B7280),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 6.h,
                                      right: 14.w,
                                      child: Text(
                                        '100 pts',
                                        style: GoogleFonts.inter(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF6B7280),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 12.h),

                        // 2. Motivational Description
                        Text(
                          activeTier.description,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF4B5563),
                            height: 1.45,
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // 3. Rank Benefits Card
                        Text(
                          'Rank Benefits',
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF111827),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          padding: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: activeTier.benefits.map((b) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('• ', style: TextStyle(color: Color(0xFF34C759))),
                                    Expanded(
                                      child: Text(
                                        b,
                                        style: GoogleFonts.inter(
                                          fontSize: 13.sp,
                                          color: const Color(0xFF374151),
                                          height: 1.35,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // 4. Unlock Next Badge Box
                        if (nextTier.rank != activeTier.rank) ...[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(color: const Color(0xFFE5E7EB)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Unlock Next Badge',
                                        style: GoogleFonts.inter(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF6B7280),
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        '100 Eco Point needed',
                                        style: GoogleFonts.inter(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF111827),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: 44.r,
                                      height: 44.r,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color(0xFFF3F4F6),
                                        border: Border.all(color: const Color(0xFFE5E7EB)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          nextTier.emoji,
                                          style: TextStyle(fontSize: 22.sp),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      '${nextTier.name} (Rank ${nextTier.rank})',
                                      style: GoogleFonts.inter(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF6B7280),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                        ],

                        // 5. How to Reach the Next Rank
                        Text(
                          'How to Reach the Next Rank',
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF111827),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          padding: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: activeTier.howToReach.map((item) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('• ', style: TextStyle(color: Color(0xFF34C759))),
                                    Expanded(
                                      child: Text(
                                        item,
                                        style: GoogleFonts.inter(
                                          fontSize: 13.sp,
                                          color: const Color(0xFF374151),
                                          height: 1.35,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),

                // Bottom CTA Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  child: PrimaryButton(
                    buttonName: 'View Leaderboard',
                    onPressed: () => Get.back(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
