import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class EcoScoreHeaderCard extends StatelessWidget {
  final int ecoScore;
  final int nextUnlockPoints;

  const EcoScoreHeaderCard({
    super.key,
    this.ecoScore = 0,
    this.nextUnlockPoints = 760,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: AppPallete.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Circular Score Display
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFECECEC), width: 6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$ecoScore',
                  style: AppTextStyle.s16w4i(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppPallete.primaryText,
                  ),
                ),
                Text(
                  'ECO SCORE',
                  style: AppTextStyle.s10w4i(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: AppPallete.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Next Unlock Text
          RichText(
            text: TextSpan(
              style: AppTextStyle.s12w4i(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppPallete.secondaryText,
              ),
              children: [
                const TextSpan(text: 'Next Achievement Unlock at '),
                TextSpan(
                  text: '$nextUnlockPoints pts',
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
    );
  }
}
