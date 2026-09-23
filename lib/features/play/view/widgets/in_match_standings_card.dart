import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/core/theme/app_pallete.dart';

class InMatchPlayer {
  final String name;
  final String badge;
  final String points;
  final bool isYou;
  final String? avatarUrl;
  final String? badgeIcon;
  final String? time;

  const InMatchPlayer({
    required this.name,
    required this.badge,
    required this.points,
    this.isYou = false,
    this.avatarUrl,
    this.badgeIcon,
    this.time,
  });
}

class InMatchStandingsCard extends StatelessWidget {
  final List<InMatchPlayer> players;

  const InMatchStandingsCard({super.key, required this.players});

  static const _rankLabels = ['1st', '2nd', '3rd', '4th', '5th'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Standings',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppPallete.primaryText,
          ),
        ),
        SizedBox(height: 10.h),
        Column(
          children: List.generate(players.length, (i) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: i < players.length - 1 ? 10.h : 0,
              ),
              child: _StandingTile(
                player: players[i],
                rank: i < _rankLabels.length ? _rankLabels[i] : '${i + 1}th',
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _StandingTile extends StatelessWidget {
  final InMatchPlayer player;
  final String rank;

  const _StandingTile({
    required this.player,
    required this.rank,
  });

  String _getBadgeIcon(String badge) {
    final b = badge.toLowerCase();
    if (b.contains('phyto') || b.contains('plankton') || b.contains('microbe')) {
      return '🦠';
    }
    if (b.contains('fish')) {
      return '🐟';
    }
    if (b.contains('garden') || b.contains('plant')) {
      return '🌱';
    }
    if (b.contains('shark')) {
      return '🦈';
    }
    return '🦠';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppPallete.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // ── Avatar ──
          CircleAvatar(
            radius: 24.r,
            backgroundColor: const Color(0xFF2A2A3A),
            backgroundImage: player.avatarUrl != null
                ? NetworkImage(player.avatarUrl!)
                : const AssetImage('assets/play/default_avatar.jpg')
                    as ImageProvider,
          ),
          SizedBox(width: 14.w),

          // ── Name & Wooden Plank Badge ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  player.isYou ? 'You' : player.name,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppPallete.primaryText,
                    letterSpacing: -0.2,
                  ),
                ),
                SizedBox(height: 6.h),

                // Wooden Pill Badge with Microbe/Phytoplankton Icon
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 4.5.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xFFFED7AA), // Warm golden highlight rim
                      width: 1.5,
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/play/wood_texture.png'),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFB45309).withValues(alpha: 0.18),
                        blurRadius: 4,
                        offset: const Offset(0, 1.5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        player.badgeIcon ?? _getBadgeIcon(player.badge),
                        style: TextStyle(fontSize: 15.sp),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        player.badge,
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.1,
                          shadows: const [
                            Shadow(
                              color: Colors.black45,
                              offset: Offset(0, 1),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Rank & Time / Points ──
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                rank,
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: AppPallete.primaryText,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                player.time ??
                    (player.points.isNotEmpty ? player.points : '2 min'),
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF10B981),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
