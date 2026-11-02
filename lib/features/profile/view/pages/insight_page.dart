import 'package:flutter/material.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_app_bar.dart';
import 'package:path_app/features/profile/view/widgets/insight_quick_action_card.dart';
import 'package:path_app/features/home/view/widgets/section_header.dart';
import 'package:path_app/features/home/view/widgets/wager_collection_banner.dart';

class InsightPage extends StatelessWidget {
  const InsightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PrimaryAppBar(
        title: 'Insights',
        subtitle: 'Tips to boost your sustainability score',
      ),
      body: AppBg(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                const InsightQuickActionGrid(),
                const SizedBox(height: 16),
                const SectionHeader(title: 'Sustainability Tips'),
                const SizedBox(height: 16),
                // Section content
                const WagerCollectionBanner(
                  title: 'Reduce Idle Time',
                  message:
                      'You idled for 45 minutes last week. Turning off your engine while waiting for orders can significantly boost your score.',
                ),
                const SizedBox(height: 12),
                const WagerCollectionBanner(
                  title: 'Smooth Acceleration',
                  message:
                      'Avoid harsh braking and rapid acceleration. Smooth driving saves fuel and earns you more eco-points per trip.',
                  backgroundColor: Color(0xFFEFF6FF),
                  borderColor: Color(0xFFDBEAFE),
                  titleColor: Color(0xFF1E3A8A),
                  messageColor: Color(0xFF1D4ED8),
                ),
                const SizedBox(height: 12),
                const WagerCollectionBanner(
                  title: 'SEV Optimization',
                  message:
                      'If using an e-bike or EV, keeping your battery between 20-80% extends its lifespan and maintains peak efficiency.',
                  backgroundColor: Color(0xFFFAF5FF),
                  borderColor: Color(0xFFF3E8FF),
                  titleColor: Color(0xFF581C87),
                  messageColor: Color(0xFF7E22CE),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
