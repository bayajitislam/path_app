import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class LiveGpsCard extends StatelessWidget {
  final String mapImageUrl;
  final String comparisonTitle;
  final String comparisonSubtitle;

  const LiveGpsCard({
    super.key,
    this.mapImageUrl =
        'https://tile.openstreetmap.org/14/4823/6160.png', // Placeholder map tile
    this.comparisonTitle = 'Eco-Route Comparison',
    this.comparisonSubtitle =
        'Your current route saves 12% more CO₂ compared to the standard Google Maps suggestion.',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppPallete.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Section: Map Preview with Live GPS Badge
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 120,
                width: double.infinity,
                child: Image.network(
                  mapImageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFFEFEFEF),
                    child: const Icon(
                      Icons.map_outlined,
                      color: AppPallete.secondaryText,
                      size: 40,
                    ),
                  ),
                ),
              ),
              // Floating Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppPallete.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.near_me_rounded,
                      size: 16,
                      color: Color(0xFF007AFF),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Live GPS Tracking Active',
                      style: AppTextStyle.s12w4i(
                        color: AppPallete.primaryText,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Bottom Section: Green Eco-Route Banner
          Container(
            padding: const EdgeInsets.all(14),
            color: const Color(0xFFEEFAF2), // Light mint green fill
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.eco_outlined,
                  color: AppPallete.primary,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comparisonTitle,
                        style: AppTextStyle.s14w4i(
                          color: const Color(0xFF064E3B),
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        comparisonSubtitle,
                        style: AppTextStyle.s12w4i(
                          color: const Color(0xFF047857),
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
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
