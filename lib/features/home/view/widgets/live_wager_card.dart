import 'package:flutter/material.dart';
import 'package:path_app/core/constants/app_images.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class LiveWagerCard extends StatelessWidget {
  final String route;
  final double amount;
  final int peopleJoined;
  final VoidCallback? onPlay;

  const LiveWagerCard({
    super.key,
    required this.route,
    required this.amount,
    required this.peopleJoined,
    this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
          // Route info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(route, style: AppTextStyle.s14w7sora()),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '${amount.toStringAsFixed(0)}\$',
                      style: AppTextStyle.s14w7sora(
                        color: AppPallete.secondaryText,
                      ).copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: Color(0xFF6B7280),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$peopleJoined People Joined',
                      style: AppTextStyle.s14w7sora(
                        color: AppPallete.secondaryText,
                      ).copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Play button
          GestureDetector(
            onTap: onPlay,
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
                    'Play',
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
