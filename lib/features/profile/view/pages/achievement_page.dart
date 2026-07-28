import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/secondary_app_bar.dart';
import 'package:path_app/features/profile/view/widgets/achievement_grid_tile.dart';
import 'package:path_app/features/profile/view/widgets/eco_score_header_card.dart';

// Import component widgets
// import 'package:path_app/features/achievement/widgets/eco_score_header_card.dart';
// import 'package:path_app/features/achievement/widgets/achievement_grid_tile.dart';

class AchievementPage extends StatelessWidget {
  const AchievementPage({super.key});

  // Achievement Items List (First 2 Unlocked by Default)
  final List<AchievementModel> _achievements = const [
    AchievementModel(
      title: 'First Steps',
      icon: Icons.eco_outlined,
      isUnlocked: true, // Unlocked
    ),
    AchievementModel(
      title: 'Getting Rolling',
      icon: Icons.alt_route_rounded,
      isUnlocked: true, // Unlocked
    ),
    AchievementModel(
      title: 'Road Warrior',
      icon: Icons.emoji_events_outlined,
      isUnlocked: false,
    ),
    AchievementModel(
      title: 'Century Rider',
      icon: Icons.route_outlined,
      isUnlocked: false,
    ),
    AchievementModel(
      title: 'Eco Conscious',
      icon: Icons.eco_outlined,
      isUnlocked: false,
    ),
    AchievementModel(
      title: 'Top 10% Eco-Score',
      icon: Icons.emoji_events_outlined,
      isUnlocked: false,
    ),
    AchievementModel(
      title: 'Consistency Champion',
      icon: Icons.trending_up_rounded,
      isUnlocked: false,
    ),
    AchievementModel(
      title: 'Daily Grinder',
      icon: Icons.alt_route_rounded,
      isUnlocked: false,
    ),
    AchievementModel(
      title: 'Carbon Cutter',
      icon: Icons.eco_outlined,
      isUnlocked: false,
    ),
    AchievementModel(
      title: 'Climate Hero',
      icon: Icons.eco_outlined,
      isUnlocked: false,
    ),
    AchievementModel(
      title: 'Green Machine',
      icon: Icons.eco_outlined,
      isUnlocked: false,
    ),
    AchievementModel(
      title: 'Horizon Chaser',
      icon: Icons.alt_route_rounded,
      isUnlocked: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final int unlockedCount = _achievements
        .where((item) => item.isUnlocked)
        .length;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const SecondaryAppBar(title: 'Achievement'),
      body: AppBg(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Eco Score Card
                const EcoScoreHeaderCard(ecoScore: 0, nextUnlockPoints: 760),

                const SizedBox(height: 20),

                // Section Title and Progress Count
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Achievements',
                      style: AppTextStyle.s14w4i(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppPallete.secondaryText,
                      ),
                    ),

                    // Badge Pill
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F8EE),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$unlockedCount / ${_achievements.length}',
                        style: AppTextStyle.s12w4i(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppPallete.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Grid View of Achievements
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _achievements.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return AchievementGridTile(
                      achievement: _achievements[index],
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
