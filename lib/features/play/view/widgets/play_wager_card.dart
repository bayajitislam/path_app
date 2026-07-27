import 'package:flutter/material.dart';
import 'package:path_app/core/constants/app_images.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class PlayWagerCard extends StatelessWidget {
  final String playerName;
  final String playerRank;
  final String? avatarUrl;
  final int playerPoints;
  final String mode;
  final double distanceKm;
  final String locationLabel;
  final int reward;
  final int slotsUsed;
  final int slotsTotal;
  final VoidCallback? onPlay;

  const PlayWagerCard({
    super.key,
    required this.playerName,
    required this.playerRank,
    this.avatarUrl,
    required this.playerPoints,
    required this.mode,
    required this.distanceKm,
    required this.locationLabel,
    required this.reward,
    required this.slotsUsed,
    required this.slotsTotal,
    this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppPallete.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Row 1: Avatar + name/rank + icons + points badge ──
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 22,
                backgroundColor: const Color(0xFF1A1A2E),
                backgroundImage: avatarUrl != null
                    ? NetworkImage(avatarUrl!)
                    : null,
                child: avatarUrl == null
                    ? Text(
                        playerName.isNotEmpty ? playerName[0] : '?',
                        style: const TextStyle(
                          color: AppPallete.white,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 10),
              // Name + rank
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      playerName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppPallete.primaryText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      playerRank,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppPallete.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              // Share/info icons
              const Icon(Icons.link, size: 20, color: AppPallete.secondaryText),
              const SizedBox(width: 8),
              // Points badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8EC),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFF5C451), width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(AppImages.coinIcon, width: 12, height: 12),
                    const SizedBox(width: 4),
                    Text(
                      '$playerPoints',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFF5C451),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ── Row 2: Mode + distance + location ──
          Row(
            children: [
              _InfoChip(
                label: mode,
                color: const Color(0xFFD9F7E8),
                textColor: AppPallete.primary,
              ),
              const SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppPallete.border),
                ),
                child: Row(
                  children: [
                    Image.asset(AppImages.linkedicon, width: 12, height: 12),
                    const SizedBox(width: 4),
                    Text(
                      '${distanceKm.toStringAsFixed(0)} km',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppPallete.primaryText,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppPallete.border),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 14,
                      color: AppPallete.primaryText,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${distanceKm.toStringAsFixed(1)} km · $locationLabel',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppPallete.primaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ── Row 3: Reward + slots + Play button ──
          Row(
            children: [
              // Reward
              Image.asset(AppImages.rewardIcon, width: 14, height: 14),
              const SizedBox(width: 4),
              Text(
                '$reward reward',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppPallete.primaryText,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(
                Icons.group_outlined,
                size: 16,
                color: AppPallete.secondaryText,
              ),
              const SizedBox(width: 4),
              Text(
                '$slotsUsed/$slotsTotal',
                style: AppTextStyle.s14w7sora(
                  color: AppPallete.secondaryText,
                ).copyWith(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              const Spacer(),
              // Play button
              GestureDetector(
                onTap: onPlay,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppPallete.primary,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        AppImages.swordLineIcon,
                        width: 16,
                        height: 16,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Play',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppPallete.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;

  const _InfoChip({
    required this.label,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
