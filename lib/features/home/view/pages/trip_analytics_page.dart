import 'package:flutter/material.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_app_bar.dart';

class TripAnalytics extends StatelessWidget {
  const TripAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PrimaryAppBar(
        title: 'Trip Analytics',
        subtitle: 'Delivery history & eco-routing',
      ),
      body: AppBg(child: Center(child: Text('Trip Analytics Page'))),
    );
  }
}
