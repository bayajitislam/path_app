import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_app_bar.dart';
import 'package:path_app/features/home/data/trip_repository.dart';
import 'package:path_app/features/home/models/delivery_trip_model.dart';
import 'package:path_app/features/home/view/widgets/delivery_history_tile.dart';
import 'package:path_app/features/home/view/widgets/live_gps_card.dart';

class TripAnalyticsPage extends StatefulWidget {
  final TripRepository repository;
  const TripAnalyticsPage({
    super.key,
    this.repository = const LocalTripRepository(),
  });

  @override
  State<TripAnalyticsPage> createState() => _TripAnalyticsPageState();
}

class _TripAnalyticsPageState extends State<TripAnalyticsPage> {
  List<DeliveryTripModel> _trips = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTrips();
  }

  Future<void> _loadTrips() async {
    final trips = await widget.repository.getRecentTrips();
    if (mounted) {
      setState(() {
        _trips = trips;
        _isLoading = false;
      });
    }
  }

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
                if (_isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  )
                else if (_trips.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Center(
                      child: Text(
                        'No recent delivery trips recorded.',
                        style: TextStyle(color: AppPallete.secondaryText),
                      ),
                    ),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _trips.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final trip = _trips[index];
                      return DeliveryHistoryTile(
                        dateTime: trip.dateTime,
                        ecoPoints: trip.ecoPoints,
                        startLabel: trip.startLabel,
                        dropoffLabel: trip.dropoffLabel,
                        distanceKm: trip.distanceKm,
                        durationMin: trip.durationMin,
                        co2Saved: trip.co2Saved,
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
