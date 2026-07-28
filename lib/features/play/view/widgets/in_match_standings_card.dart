import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class InMatchPlayer {
  final String name;
  final String badge;
  final String points;
  final bool isYou;
  final String? avatarUrl;

  const InMatchPlayer({
    required this.name,
    required this.badge,
    required this.points,
    this.isYou = false,
    this.avatarUrl,
  });
}

class InMatchStandingsCard extends StatelessWidget {
  final List<InMatchPlayer> players;

  const InMatchStandingsCard({super.key, required this.players});

  static const _rankLabels = ['1st', '2nd', '3rd', '4th', '5th'];
  static const _rankColors = [
    Colors.blue, // gold
    Colors.green, // silver
    Colors.red, // bronze
    AppPallete.secondaryText,
    AppPallete.secondaryText,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Standings',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppPallete.primaryText,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: List.generate(players.length, (i) {
            return Padding(
              padding: EdgeInsets.only(bottom: i < players.length - 1 ? 10 : 0),
              child: _StandingTile(
                player: players[i],
                rank: i < _rankLabels.length ? _rankLabels[i] : '${i + 1}th',
                rankColor: i < _rankColors.length
                    ? _rankColors[i]
                    : AppPallete.secondaryText,
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _StandingTile extends StatelessWidget {
  final InMatchPlayer player;
  final String rank;
  final Color rankColor;

  const _StandingTile({
    required this.player,
    required this.rank,
    required this.rankColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppPallete.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFF2A2A3A),
            backgroundImage: player.avatarUrl != null
                ? NetworkImage(player.avatarUrl!)
                : null,
            child: player.avatarUrl == null
                ? Text(
                    player.name.isNotEmpty ? player.name[0] : '?',
                    style: const TextStyle(
                      color: AppPallete.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          // Name + badge
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.isYou ? 'You' : player.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppPallete.primaryText,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppPallete.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      player.badge,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppPallete.secondaryText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Rank + points
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                rank,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: rankColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                player.points,
                style: AppTextStyle.s10w4i(
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF059669),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
