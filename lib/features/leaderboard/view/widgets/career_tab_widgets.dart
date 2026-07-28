import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

// ─── Career Period Toggle (Weekly / Monthly / All Time) ──────────────────────
class CareerPeriodToggle extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onChanged;
  final List<String> tabs;

  const CareerPeriodToggle({
    super.key,
    this.selectedIndex = 0,
    this.onChanged,
    this.tabs = const ['All Time', 'Monthly', 'Weekly'],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6), // Light grey background container
        border: Border.all(color: AppPallete.border, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: List.generate(tabs.length, (i) {
          final isSelected = i == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged?.call(i),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppPallete.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? AppPallete.border
                        : AppPallete.transparent,
                    width: 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Text(
                  tabs[i],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? AppPallete.primaryText
                        : AppPallete.secondaryText,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class CareerBadge {
  final String emoji;
  final String name;
  final int rank;

  const CareerBadge({
    required this.emoji,
    required this.name,
    required this.rank,
  });
}

class CareerBadgeScroller extends StatefulWidget {
  final List<CareerBadge> badges;
  final int userRankIndex; // User's fixed rank (permanently highlighted in green)
  final ValueChanged<int>? onPageChanged;

  const CareerBadgeScroller({
    super.key,
    required this.badges,
    this.userRankIndex = 3, // Default to Rank 4 / Dolphin
    this.onPageChanged,
  });

  @override
  State<CareerBadgeScroller> createState() => _CareerBadgeScrollerState();
}

class _CareerBadgeScrollerState extends State<CareerBadgeScroller> {
  late PageController _pageController;
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    // Start scrolled directly at the user's current rank
    _currentPage = widget.userRankIndex.toDouble();
    _pageController = PageController(
      initialPage: widget.userRankIndex,
      viewportFraction: 0.26, // Controls spacing between items
    );

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0.0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.badges.length,
        onPageChanged: widget.onPageChanged,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final badge = widget.badges[index];

          // 1. SCALING: Based purely on scroll position (center item = 1.0, side items = small)
          final double distance = (_currentPage - index).abs();
          final double scale = (1.0 - (distance * 0.22)).clamp(0.60, 1.0);

          // 2. GREEN HIGHLIGHT: Locked ONLY to the user's actual rank
          final bool isUserRank = index == widget.userRankIndex;

          return Transform.scale(
            scale: scale,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Circular Badge Avatar
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: isUserRank
                          ? const Color(0xFF00C853) // Green border ONLY for user's rank
                          : Colors.transparent,
                      width: 2.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isUserRank
                            ? const Color(0xFF00C853).withValues(alpha: 0.28)
                            : Colors.black.withValues(alpha: 0.06),
                        blurRadius: isUserRank ? 12 : 6,
                        spreadRadius: isUserRank ? 2 : 0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      badge.emoji,
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Badge Name
                Text(
                  badge.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isUserRank ? FontWeight.w700 : FontWeight.w500,
                    color: isUserRank
                        ? const Color(0xFF00C853) // Green text ONLY for user's rank
                        : Colors.black54,
                  ),
                ),
                const SizedBox(height: 2),

                // Rank Label
                Text(
                  'Rank ${badge.rank}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ─── Career Rank Progress Card ────────────────────────────────────────────────

class CareerRankProgressCard extends StatefulWidget {
  final String badgeEmoji;
  final String badgeName;
  final String rankLabel;
  final int currentPoints;
  final int maxPoints;
  final String description;
  final String? unlockMessage;

  const CareerRankProgressCard({
    super.key,
    required this.badgeEmoji,
    required this.badgeName,
    required this.rankLabel,
    required this.currentPoints,
    required this.maxPoints,
    required this.description,
    this.unlockMessage,
  });

  @override
  State<CareerRankProgressCard> createState() => _CareerRankProgressCardState();
}

class _CareerRankProgressCardState extends State<CareerRankProgressCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _barAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _barAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = (widget.currentPoints / widget.maxPoints).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(16),
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
          // Badge + rank label
          Row(
            children: [
              Text(widget.badgeEmoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Text(
                widget.badgeName,
                style: AppTextStyle.s14w4i(
                  color: AppPallete.primaryText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppPallete.border),
                ),
                child: Text(
                  widget.rankLabel,
                  style: AppTextStyle.s10w4i(
                    color: AppPallete.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Progress bar + points
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.currentPoints}',
                style: AppTextStyle.s12w4i(
                  color: AppPallete.primaryText,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${widget.maxPoints} pts',
                style: AppTextStyle.s12w4i(
                  color: AppPallete.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          AnimatedBuilder(
            animation: _barAnim,
            builder: (_, _) => ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: _barAnim.value * progress,
                minHeight: 6,
                backgroundColor: const Color(0xFFE0E0E0),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppPallete.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Description
          Text(
            widget.description,
            style: AppTextStyle.s12w4i(
              color: AppPallete.primaryText,
              fontWeight: FontWeight.w400,
            ),
          ),

          if (widget.unlockMessage != null) ...[
            const SizedBox(height: 10),
            const Divider(height: 1, color: Color(0xFFEEEEEE)),
            const SizedBox(height: 10),
            Text(
              'Unlock Next Badge',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppPallete.primaryText,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              widget.unlockMessage!,
              style: const TextStyle(
                fontSize: 11,
                color: AppPallete.secondaryText,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─── Participant Tile ─────────────────────────────────────────────────────────

class LeaderboardParticipant {
  final String name;
  final int safeTrips;
  final String badge;
  final String rank;
  final int points;
  final String? avatarUrl;

  const LeaderboardParticipant({
    required this.name,
    required this.safeTrips,
    required this.badge,
    required this.rank,
    required this.points,
    this.avatarUrl,
  });
}

class CareerParticipantTile extends StatelessWidget {
  final int position;
  final LeaderboardParticipant participant;

  const CareerParticipantTile({
    super.key,
    required this.position,
    required this.participant,
  });

  static const _medalEmojis = ['🥇', '🥈', '🥉'];

  Color get _avatarBorderColor {
    switch (position) {
      case 1:
        return const Color(0xFFFF4B4B); // Red accent for 1st
      case 2:
        return const Color(0xFF0038FF); // Blue accent for 2nd
      case 3:
        return const Color(0xFFEFE000); // Yellow accent for 3rd
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left Ranking Indicator (Medal + Number for 1-3, Number only for 4+)
        SizedBox(
          width: 36,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (position <= 3) ...[
                Text(
                  _medalEmojis[position - 1],
                  style: const TextStyle(fontSize: 16),
                ),
              ],
              Text(
                '$position',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 4),

        // Main Card Container
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: AppPallete.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppPallete.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                // Avatar with Colored Border
                Container(
                  padding: const EdgeInsets.all(2.5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _avatarBorderColor,
                  ),
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: const Color(0xFF2A2A3A),
                    backgroundImage: participant.avatarUrl != null
                        ? NetworkImage(participant.avatarUrl!)
                        : null,
                    child: participant.avatarUrl == null
                        ? Text(
                            participant.name.isNotEmpty
                                ? participant.name[0]
                                : '?',
                            style: const TextStyle(
                              color: AppPallete.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          )
                        : null,
                  ),
                ),
                const SizedBox(width: 12),

                // Name, Safe Trips Pill, and Sub-badge
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              participant.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppPallete.primaryText,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Safe Trips Pill Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9FAFB),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppPallete.border,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              '${participant.safeTrips} Safe Trips',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: AppPallete.secondaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text('🌿', style: const TextStyle(fontSize: 11)),
                          const SizedBox(width: 4),
                          Text(
                            participant.badge,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppPallete.secondaryText,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Rank text + points on right side
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      participant.rank,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppPallete.primaryText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${participant.points} pts',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF059669), // Green text for points
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Participants List ────────────────────────────────────────────────────────

class CareerParticipantsList extends StatelessWidget {
  final List<LeaderboardParticipant> participants;

  const CareerParticipantsList({super.key, required this.participants});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Participants',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppPallete.primaryText,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: List.generate(participants.length, (i) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: i < participants.length - 1 ? 10 : 0,
              ),
              child: CareerParticipantTile(
                position: i + 1,
                participant: participants[i],
              ),
            );
          }),
        ),
      ],
    );
  }
}
