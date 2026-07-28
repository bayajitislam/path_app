import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class EarningMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;

  const EarningMetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppPallete.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title
          Text(
            title,
            style: AppTextStyle.s12w4i(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppPallete.secondaryText,
            ),
          ),
          const SizedBox(height: 6),

          // Main Value Highlight
          Text(
            value,
            style: AppTextStyle.s16w4i(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppPallete.primaryText,
            ),
          ),
          const SizedBox(height: 6),

          // Subtitle Footer
          Text(
            subtitle,
            style: AppTextStyle.s10w4i(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: AppPallete.secondaryText.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }
}
