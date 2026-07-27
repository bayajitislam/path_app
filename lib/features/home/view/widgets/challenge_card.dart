import 'package:flutter/material.dart';
import 'package:path_app/core/constants/app_images.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class ChallengeCard extends StatelessWidget {
  final String name;
  final String rank;
  final String? avatarUrl;
  final VoidCallback? onChallenge;

  const ChallengeCard({
    super.key,
    required this.name,
    required this.rank,
    this.avatarUrl,
    this.onChallenge,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFF1A1A2E),
            backgroundImage: avatarUrl != null
                ? NetworkImage(avatarUrl!)
                : null,
            child: avatarUrl == null
                ? Text(
                    name.isNotEmpty ? name[0] : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          // Name + rank
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyle.s14w7sora(
                    color: AppPallete.primaryText
                  )
                ),
                const SizedBox(height: 2),
                Text(
                  rank,
                  style: AppTextStyle.s12w4i(
                    color: AppPallete.secondaryText
                  )
                ),
              ],
            ),
          ),
          // Challenge button
          GestureDetector(
            onTap: onChallenge,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: AppPallete.primary,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(AppImages.swordLineIcon, width: 14, height: 14),
                  SizedBox(width: 6),
                  Text(
                    'Challenge',
                    style: AppTextStyle.s14w7sora(color: AppPallete.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
