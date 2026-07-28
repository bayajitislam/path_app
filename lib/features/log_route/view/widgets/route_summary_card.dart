import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class RouteSummaryCard extends StatelessWidget {
  final String title;
  final String routeType;
  final String distance;
  final String duration;
  final String averageSpeed;
  final String co2Saved;
  final String date;
  final String timeRange;
  final int points;
  final String wager;

  const RouteSummaryCard({
    super.key,
    this.title = 'Home → City Supermarket',
    this.routeType = 'Eco Route',
    this.distance = '8.4 mi',
    this.duration = '26 min',
    this.averageSpeed = '28 mph',
    this.co2Saved = '0.7 kg',
    this.date = '14 July 2026',
    this.timeRange = '09:42 AM – 10:08 AM',
    this.points = 95,
    this.wager = '£20',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppPallete.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Route Title & Eco Badge
          Row(
            children: [
              Flexible(
                child: Text(
                  title,
                  style: AppTextStyle.s14w4i(
                    color: AppPallete.primaryText,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 6),
              // Eco Route Pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppPallete.border,
                    width: 0.8,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('🌱', style: TextStyle(fontSize: 10)),
                    const SizedBox(width: 3),
                    Text(
                      routeType,
                      style: AppTextStyle.s10w4i(
                        color: AppPallete.secondaryText,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Main Body: Metrics on Left, Points & Wager on Right
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column (Distance, Duration, Average Speed)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('📍', 'Distance:', distance),
                    const SizedBox(height: 3),
                    _buildInfoRow('⏱', 'Duration:', duration),
                    const SizedBox(height: 3),
                    _buildInfoRow('🚗', 'Average Speed:', averageSpeed),
                  ],
                ),
              ),

              // Right Column (Points aligned with Distance, Wager aligned with Duration)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$points pts',
                    style: AppTextStyle.s16w4i(
                      color: const Color(0xFF059669),
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Wager: $wager',
                    style: AppTextStyle.s12w4i(
                      color: AppPallete.secondaryText,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Bottom Footer Row: CO2 Saved, Date, Time Range (Non-overlapping)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // CO2 Saved
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🌱 ', style: TextStyle(fontSize: 11)),
                  Text(
                    'CO₂ Saved: ',
                    style: AppTextStyle.s12w4i(
                      color: AppPallete.primaryText,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    co2Saved,
                    style: AppTextStyle.s12w4i(
                      color: AppPallete.primaryText,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),

              // Date
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('📅 ', style: TextStyle(fontSize: 11)),
                  Text(
                    date,
                    style: AppTextStyle.s12w4i(
                      color: AppPallete.primaryText,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),

              // Time
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🕒 ', style: TextStyle(fontSize: 11)),
                  Text(
                    timeRange,
                    style: AppTextStyle.s12w4i(
                      color: AppPallete.primaryText,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper row widget for metric details (clean and modular)
  Widget _buildInfoRow(String emoji, String title, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 12)),
        const SizedBox(width: 4),
        Text(
          title,
          style: AppTextStyle.s12w4i(
            color: AppPallete.primaryText,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: AppTextStyle.s12w4i(
            color: AppPallete.secondaryText,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
