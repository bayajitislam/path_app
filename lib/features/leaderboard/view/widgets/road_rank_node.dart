import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/features/leaderboard/models/rank_tier_model.dart';

/// Checkpoint badge node sitting on the cosmic road with adjacent rank title and rank level.
class RoadRankNode extends StatelessWidget {
  final RankTierModel tier;
  final VoidCallback onTap;

  const RoadRankNode({
    super.key,
    required this.tier,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isCurrent = tier.isCurrent;
    final isUnlocked = tier.isUnlocked;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Circular Badge Avatar ─────────────────────────
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: isCurrent ? 52.r : 46.r,
                height: isCurrent ? 52.r : 46.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCurrent
                      ? Colors.white
                      : (isUnlocked
                          ? Colors.white
                          : const Color(0xFF64748B).withValues(alpha: 0.55)),
                  border: Border.all(
                    color: isCurrent
                        ? const Color(0xFF00E5FF)
                        : (isUnlocked
                            ? const Color(0xFF94A3B8)
                            : Colors.white.withValues(alpha: 0.45)),
                    width: isCurrent ? 2.5 : 1.5,
                  ),
                  boxShadow: isCurrent
                      ? [
                          BoxShadow(
                            color: const Color(0xFF00E676).withValues(alpha: 0.55),
                            blurRadius: 18,
                            offset: const Offset(0, 4),
                            spreadRadius: 3,
                          ),
                          BoxShadow(
                            color: const Color(0xFF00E5FF).withValues(alpha: 0.65),
                            blurRadius: 20,
                            spreadRadius: 4,
                          ),
                        ]
                      : (isUnlocked
                          ? [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.35),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.25),
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ]),
                ),
                child: Center(
                  child: Opacity(
                    opacity: isUnlocked ? 1.0 : 0.85,
                    child: Text(
                      tier.emoji,
                      style: TextStyle(
                        fontSize: isCurrent ? 24.sp : 19.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(width: 8.w),

          // ── Rank Name & Level Labels ──────────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tier.name,
                style: GoogleFonts.inter(
                  fontSize: isCurrent ? 14.sp : 12.sp,
                  fontWeight: isCurrent ? FontWeight.w800 : FontWeight.w600,
                  color: isCurrent
                      ? const Color(0xFF00E5A3)
                      : Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.9),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                'Rank ${tier.rank}',
                style: GoogleFonts.inter(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: isCurrent
                      ? const Color(0xFF86EFAC)
                      : Colors.white.withValues(alpha: 0.75),
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.8),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
