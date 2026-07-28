import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_app_bar.dart';
import 'package:path_app/features/home/view/widgets/delivery_history_tile.dart';
import 'package:path_app/features/home/view/widgets/live_gps_card.dart';

// Import your standalone public widgets here
// import 'package:path_app/features/trip_analytics/widgets/live_gps_card.dart';
// import 'package:path_app/features/trip_analytics/widgets/delivery_history_tile.dart';

class TripAnalytics extends StatelessWidget {
  const TripAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PrimaryAppBar(
        title: 'Trip Analytics',
        subtitle: 'Delivery history & eco-routing',
      ),
      body: AppBg(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Map & Eco Comparison Card
                const LiveGpsCard(),

                const SizedBox(height: 20),

                // Section Title
                Text(
                  'Delivery History',
                  style: AppTextStyle.s16w4i(
                    color: AppPallete.primaryText,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 12),

                // Delivery History List
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return const DeliveryHistoryTile(
                      dateTime: 'Today, 2:30 PM',
                      ecoPoints: 12,
                      startLabel: 'Burger King, High St',
                      dropoffLabel: '142 Riverside Apts',
                      distanceKm: 4.2,
                      durationMin: 18,
                      co2Saved: 0.8,
                    );
                  },
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
