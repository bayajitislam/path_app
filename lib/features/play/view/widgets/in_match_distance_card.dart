import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class InMatchDistanceCard extends StatelessWidget {
  final double targetKm;
  final double currentKm;

  const InMatchDistanceCard({
    super.key,
    required this.targetKm,
    required this.currentKm,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (currentKm / targetKm).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppPallete.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Target distance',
                style: AppTextStyle.s14w7sora(
                  color: AppPallete.primaryText,
                ).copyWith(fontWeight: FontWeight.w400),
              ),
              Text(
                '${targetKm.toStringAsFixed(0)} km',
                style: AppTextStyle.s14w7sora(
                  color: AppPallete.primaryText,
                ).copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(height: 17),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 16,
              backgroundColor: const Color(0xFFE0E0E0),
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppPallete.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
