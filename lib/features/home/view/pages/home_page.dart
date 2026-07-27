import 'package:flutter/material.dart';
import 'package:flutter_devlog/flutter_devlog.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/features/home/view/widgets/challenge_card.dart';
import 'package:path_app/features/home/view/widgets/home_app_bar.dart';
import 'package:path_app/features/home/view/widgets/live_wager_card.dart';
import 'package:path_app/features/home/view/widgets/home_quick_action_card.dart';
import 'package:path_app/features/home/view/widgets/recent_trip_card.dart';
import 'package:path_app/features/home/view/widgets/section_header.dart';
import 'package:path_app/features/home/view/widgets/sustainability_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AppPallete.white,
      appBar: HomeAppBar(userName: 'Kieran', onBellTap: () {}),
      body: AppBg(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                SustainabilityCard(score: 84, jackpotEarned: 140),
                SizedBox(height: 14),
                HomeQuickActionGrid(),
                SizedBox(height: 14),
                SectionHeader(
                  title: 'Live Wager',
                  onViewAll: () {
                    DevLog.ui('Clicked View All');
                  },
                ),
                SizedBox(height: 12),
                LiveWagerCard(
                  route: 'Downtown → New Hill',
                  amount: 20,
                  peopleJoined: 20,
                  onPlay: () {
                    DevLog.ui('Clicked Downtown → New Hill');
                  },
                ),
                SizedBox(height: 14),
                SectionHeader(
                  title: 'Challenge Your Friends',
                  onViewAll: () {
                    DevLog.ui('Clicked View All');
                  },
                ),
                SizedBox(height: 14),
                ChallengeCard(
                  name: 'Maya Osei',
                  rank: 'Diamond I',
                  onChallenge: () {
                    DevLog.ui('Clicked Challenge Maya Osei');
                  },
                ),
                SizedBox(height: 14),
                SectionHeader(
                  title: 'Recent Trips',
                  onViewAll: () {
                    DevLog.ui('Clicked View All');
                  },
                ),
                SizedBox(height: 12),

                //ListView Genarate
                RecentTripCard(
                  destination: 'Downtown Delivery',
                  time: 'Today, 2:30 PM',
                  points: 12,
                  distanceKm: 4.2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
