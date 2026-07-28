import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';

class ProfileHeroCard extends StatelessWidget {
  final String name;
  final String rank;
  final int winStreak;
  final String topPercent;
  final int ecoScore;
  final String? avatarUrl;

  const ProfileHeroCard({
    super.key,
    required this.name,
    required this.rank,
    required this.winStreak,
    required this.topPercent,
    required this.ecoScore,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
      decoration: BoxDecoration(
        color: AppPallete.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Avatar ──────────────────────────────────────────
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipOval(
              child: avatarUrl != null
                  ? Image.network(avatarUrl!, fit: BoxFit.cover)
                  : Image.asset(
                      'assets/images/avatar_placeholder.png',
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        color: const Color(0xFF87CEEB),
                        child: Center(
                          child: Text(
                            name.isNotEmpty ? name[0] : '?',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: AppPallete.white,
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ),

          const SizedBox(height: 14),

          // ── Name ────────────────────────────────────────────
          Text(
            name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppPallete.primaryText,
            ),
          ),

          const SizedBox(height: 6),

          // ── Rank ────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/galaxy_rank.png',
                width: 16,
                height: 16,
                errorBuilder: (_, _, _) => const Icon(
                  Icons.auto_awesome,
                  size: 15,
                  color: AppPallete.secondaryText,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                rank,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppPallete.secondaryText,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ── Win Streak badge ─────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            decoration: BoxDecoration(
              color: AppPallete.primary,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🔥', style: TextStyle(fontSize: 14)),
                const SizedBox(width: 6),
                Text(
                  'Win Streak $winStreak',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppPallete.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // ── Top % ────────────────────────────────────────────
          Text(
            'Top $topPercent',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppPallete.primaryText,
            ),
          ),

          const SizedBox(height: 16),

          // ── Eco Score circle ─────────────────────────────────
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFF3F4F6), width: 4),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$ecoScore',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppPallete.primaryText,
                    height: 1.1,
                  ),
                ),
                const Text(
                  'ECO SCORE',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: AppPallete.secondaryText,
                    letterSpacing: 0.5,
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
