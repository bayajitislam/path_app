import 'package:flutter/material.dart';
import 'package:path_app/core/constants/app_images.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/secondary_app_bar.dart';
import 'package:path_app/features/profile/view/widgets/rank_leaderboard_tile.dart';

// Import component widget
// import 'package:path_app/features/career_rank/widgets/rank_leaderboard_tile.dart';

class CareerRankPage extends StatelessWidget {
  const CareerRankPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock user ranking data matching the design screenshot
    final List<Map<String, dynamic>> leaderboardData = [
      {'rank': 1, 'name': 'Sofia Ansarui', 'score': 760, 'emoji': '🪐'},
      {'rank': 2, 'name': 'Sofia Ansarui', 'score': 760, 'emoji': '☀️'},
      {'rank': 3, 'name': 'Sofia Ansarui', 'score': 760, 'emoji': '🌍'},
      {'rank': 4, 'name': 'Sofia Ansarui', 'score': 760, 'emoji': '🏙️'},
      {'rank': 5, 'name': 'Sofia Ansarui', 'score': 760, 'emoji': '💐'},
      {'rank': 6, 'name': 'Sofia Ansarui', 'score': 760, 'emoji': '🌳'},
      {'rank': 7, 'name': 'Sofia Ansarui', 'score': 760, 'emoji': '🌱'},
      {'rank': 112, 'name': 'You', 'score': 760, 'emoji': '🌱', 'isUser': true},
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const SecondaryAppBar(title: 'Career Rank'),
      body: AppBg(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                const SizedBox(height: 10),

                // ── Top Podium Header Illustration ──
                Container(
                  height: 140,
                  alignment: Alignment.center,
                  child: Image.asset(AppImages.rank1),
                ),

                const SizedBox(height: 20),

                // ── Leaderboard List ──
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: leaderboardData.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = leaderboardData[index];
                    return RankLeaderboardTile(
                      rank: item['rank'] as int,
                      name: item['name'] as String,
                      score: item['score'] as int,
                      avatarEmoji: item['emoji'] as String,
                      isCurrentUser: item['isUser'] ?? false,
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
