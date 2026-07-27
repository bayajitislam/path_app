import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class SustainabilityCard extends StatelessWidget {
  final int score;
  final double jackpotEarned;

  const SustainabilityCard({
    super.key,
    required this.score,
    required this.jackpotEarned,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppPallete.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sustainability Score',
                  style: AppTextStyle.s14w4i(
                    color: const Color(0xFFD1FAE5),
                  ).copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  '$score',
                  style: const TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Jackpot Earned \$${jackpotEarned.toStringAsFixed(0)}',
                  style: AppTextStyle.s12w4i(color: const Color(0xFFA7F3D0)),
                ),
              ],
            ),
          ),
          // Right: leaf icon circle
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppPallete.white, width: 4),
            ),
            child: const Center(
              child: Icon(
                Icons.eco_outlined,
                color: AppPallete.white,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
