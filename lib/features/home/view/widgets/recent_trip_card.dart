import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class RecentTripCard extends StatelessWidget {
  final String destination;
  final String time;
  final int points;
  final double distanceKm;
  final VoidCallback? onTap;

  const RecentTripCard({
    super.key,
    required this.destination,
    required this.time,
    required this.points,
    required this.distanceKm,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            // Location icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(33),
              ),
              child: const Center(
                child: Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: AppPallete.primaryText,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Destination + time
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destination,
                    style: AppTextStyle.s14w4i(
                      color: AppPallete.primaryText,
                    ).copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    time,
                    style: AppTextStyle.s12w4i(color: AppPallete.secondaryText),
                  ),
                ],
              ),
            ),
            // Points + distance
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '+$points pts',
                  style: AppTextStyle.s14w4i(color: const Color(0xFF059669)),
                ),
                const SizedBox(height: 2),
                Text(
                  '${distanceKm.toStringAsFixed(1)} km',
                  style: AppTextStyle.s12w4i(color: AppPallete.secondaryText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
