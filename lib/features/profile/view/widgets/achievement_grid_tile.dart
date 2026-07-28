import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class AchievementModel {
  final String title;
  final IconData icon;
  final bool isUnlocked;

  const AchievementModel({
    required this.title,
    required this.icon,
    this.isUnlocked = false,
  });
}

class AchievementGridTile extends StatelessWidget {
  final AchievementModel achievement;

  const AchievementGridTile({super.key, required this.achievement});

  @override
  Widget build(BuildContext context) {
    final bool unlocked = achievement.isUnlocked;

    return Container(
      decoration: BoxDecoration(
        color: unlocked
            ? const Color(0xFFEBFDF2) // Vibrant light green for unlocked
            : AppPallete.white.withValues(alpha: 0.6), // Faded white for locked
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: unlocked
              ? AppPallete.primary.withValues(alpha: 0.4)
              : AppPallete.border,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            achievement.icon,
            size: 26,
            color: unlocked
                ? AppPallete.primary
                : AppPallete.secondaryText.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 8),
          Text(
            achievement.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.s12w4i(
              fontSize: 11,
              fontWeight: unlocked ? FontWeight.w700 : FontWeight.w500,
              color: unlocked
                  ? AppPallete.primaryText
                  : AppPallete.secondaryText.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
