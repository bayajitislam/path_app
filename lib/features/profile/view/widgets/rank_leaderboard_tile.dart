import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class RankLeaderboardTile extends StatelessWidget {
  final int rank;
  final String name;
  final int score;
  final String avatarEmoji;
  final bool isCurrentUser;

  const RankLeaderboardTile({
    super.key,
    required this.rank,
    required this.name,
    this.score = 760,
    this.avatarEmoji = '🌱',
    this.isCurrentUser = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppPallete.white,
        borderRadius: BorderRadius.circular(16),
        border: isCurrentUser
            ? Border.all(
                color: AppPallete.primary.withValues(alpha: 0.5),
                width: 1.5,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Circular Avatar / Emoji Icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFF9FAFB),
              border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
            ),
            alignment: Alignment.center,
            child: Text(avatarEmoji, style: const TextStyle(fontSize: 20)),
          ),
          const SizedBox(width: 12),

          // User Name & Sustainable Score
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyle.s14w4i(
                    fontSize: 14,
                    fontWeight: isCurrentUser
                        ? FontWeight.w800
                        : FontWeight.w700,
                    color: AppPallete.primaryText,
                  ),
                ),
                const SizedBox(height: 2),
                RichText(
                  text: TextSpan(
                    style: AppTextStyle.s12w4i(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF6B7280),
                    ),
                    children: [
                      const TextSpan(text: 'Sustainable Score : '),
                      TextSpan(
                        text: '$score pts',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppPallete.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Medal Icon (for top 3) or Rank Number
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (rank == 1) ...[
                const Text('🥇 ', style: TextStyle(fontSize: 20)),
              ] else if (rank == 2) ...[
                const Text('🥈 ', style: TextStyle(fontSize: 20)),
              ] else if (rank == 3) ...[
                const Text('🥉 ', style: TextStyle(fontSize: 20)),
              ],
              if (rank <= 3)
                Text(
                  '$rank',
                  style: AppTextStyle.s16w4i(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppPallete.primary,
                  ),
                )
              else
                Text(
                  '$rank',
                  style: AppTextStyle.s16w4i(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppPallete.primary,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
