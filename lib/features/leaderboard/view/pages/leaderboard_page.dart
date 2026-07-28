import 'package:flutter/material.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_app_bar.dart';
import 'package:path_app/features/leaderboard/view/widgets/leaderboard_tab_filter.dart';
import 'package:path_app/features/leaderboard/view/widgets/jackpot_tab_widgets.dart';
import 'package:path_app/features/leaderboard/view/widgets/career_tab_widgets.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  int _mainTab = 0; // 0 = Jackpot, 1 = Career

  // Jackpot tab state
  bool _showRankReveal = false;

  // Career tab state
  int _badgeIndex = 2; // Dolphin selected by default
  int _periodIndex = 0; // All Time

  // Jackpot Weekly/Monthly toggle (image 2)
  int _jackpotPeriod = 0; // 0 = Weekly, 1 = Monthly

  static const _badges = [
    CareerBadge(emoji: '🦠', name: 'Phytoplankton', rank: 2),
    CareerBadge(emoji: '🐟', name: 'Small Fish', rank: 3),
    CareerBadge(emoji: '🐬', name: 'Dolphin', rank: 4),
    CareerBadge(emoji: '🦈', name: 'Shark', rank: 5),
    CareerBadge(emoji: '🐻', name: 'Bear', rank: 6),
    CareerBadge(emoji: '🦁', name: 'Lion', rank: 7),
  ];

  static const _participants = [
    LeaderboardParticipant(
      name: 'Sofia Ansarui',
      safeTrips: 42,
      badge: 'Garden',
      rank: '1st',
      points: 985,
    ),
    LeaderboardParticipant(
      name: 'Sofia Ansarui',
      safeTrips: 32,
      badge: 'Phytoplankton',
      rank: '2nd',
      points: 985,
    ),
    LeaderboardParticipant(
      name: 'Sofia Ansarui',
      safeTrips: 22,
      badge: 'Small Fish',
      rank: '3rd',
      points: 985,
    ),
    LeaderboardParticipant(
      name: 'Sofia Ansarui',
      safeTrips: 22,
      badge: 'Small Fish',
      rank: '4th',
      points: 985,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PrimaryAppBar(
        title: 'Career Leaderboard',
        subtitle: 'See how you rank against other drivers',
        showBackButton: false,
      ),
      body: AppBg(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Main Tab Filter ──────────────────────────────
                LeaderboardTabFilter(
                  selectedIndex: _mainTab,
                  onChanged: (i) => setState(() {
                    _mainTab = i;
                    _showRankReveal = false;
                  }),
                ),
                const SizedBox(height: 16),

                // ── Tab Content ──────────────────────────────────
                if (_mainTab == 0) ...[
                  _buildJackpotTab(),
                ] else ...[
                  _buildCareerTab(),
                ],

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Jackpot Tab ────────────────────────────────────────────────────────────

  Widget _buildJackpotTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pot stats
        JackpotPotStatsCard(totalPot: 250, prizePool: 19, winners: 0),
        const SizedBox(height: 12),

        if (!_showRankReveal) ...[
          // Congrats card — tap to reveal rank
          JackpotCongratsCard(
            points: 985,
            percentage: 99,
            topPercent: '18%',
            estimatedReward: 65,
            eligibleTo: const ['Weekly Jackpot', 'Monthly Jackpot'],
            nextUnlock: 'Need only 2 more eco trips',
            onTap: () => setState(() => _showRankReveal = true),
          ),
        ] else ...[
          // Weekly / Monthly toggle
          _JackpotPeriodToggle(
            selectedIndex: _jackpotPeriod,
            onChanged: (i) => setState(() => _jackpotPeriod = i),
          ),
          const SizedBox(height: 16),

          // Confetti bg + rank card
          Stack(
            children: [
              // Confetti behind
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: 220,
                  child: CustomPaint(
                    size: const Size(double.infinity, 220),
                    painter: _ConfettiBgPainter(),
                  ),
                ),
              ),
              // Rank card on top
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: JackpotRankRevealCard(rank: 36, topPercent: '18%'),
              ),
            ],
          ),
        ],
      ],
    );
  }

  // ── Career Tab ─────────────────────────────────────────────────────────────

  Widget _buildCareerTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badge scroller
        CareerBadgeScroller(
          badges: _badges,
          userRankIndex: _badgeIndex,
          onPageChanged: (i) => setState(() => _badgeIndex = i),
        ),
        const SizedBox(height: 16),

        // Rank progress card
        CareerRankProgressCard(
          badgeEmoji: _badges[_badgeIndex].emoji,
          badgeName: _badges[_badgeIndex].name,
          rankLabel: 'Rank ${_badges[_badgeIndex].rank} · Your Rank',
          currentPoints: 0,
          maxPoints: 198,
          description:
              'Your efforts are starting to stand out. Keep choosing greener routes to swim toward bigger rewards',
          unlockMessage: '100 Eco Point needed',
        ),
        const SizedBox(height: 16),

        // Period toggle
        CareerPeriodToggle(
          selectedIndex: _periodIndex,
          onChanged: (i) => setState(() => _periodIndex = i),
          tabs: const ['All Time', 'Monthly', 'Weekly'],
        ),
        const SizedBox(height: 16),

        // Participants
        CareerParticipantsList(participants: _participants),
      ],
    );
  }
}

// ─── Jackpot Period Toggle ────────────────────────────────────────────────────

class _JackpotPeriodToggle extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onChanged;

  const _JackpotPeriodToggle({required this.selectedIndex, this.onChanged});

  static const _tabs = ['Weekly', 'Monthly'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_tabs.length, (i) {
        final isSelected = i == selectedIndex;
        return GestureDetector(
          onTap: () => onChanged?.call(i),
          child: Padding(
            padding: EdgeInsets.only(right: i < _tabs.length - 1 ? 20 : 0),
            child: Column(
              children: [
                Text(
                  _tabs[i],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                    color: isSelected
                        ? const Color(0xFF1A1A2E)
                        : const Color(0xFF636363),
                  ),
                ),
                const SizedBox(height: 4),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 2,
                  width: isSelected ? 28 : 0,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A2E),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

// ─── Confetti Background Painter ─────────────────────────────────────────────

class _ConfettiBgPainter extends CustomPainter {
  static const _colors = [
    Color(0xFFFF6B6B),
    Color(0xFFFFD93D),
    Color(0xFF6BCB77),
    Color(0xFF4D96FF),
    Color(0xFFFF6BB5),
    Color(0xFF00C9A7),
    Color(0xFFFF922B),
  ];

  static const _pieces = [
    (0.1, 0.1, 12.0, 6.0, 0.3, 0),
    (0.2, 0.3, 8.0, 5.0, -0.5, 1),
    (0.35, 0.05, 14.0, 7.0, 0.8, 2),
    (0.5, 0.2, 10.0, 5.0, -0.2, 3),
    (0.65, 0.08, 8.0, 6.0, 0.6, 4),
    (0.8, 0.25, 12.0, 5.0, -0.4, 5),
    (0.9, 0.12, 9.0, 7.0, 0.9, 6),
    (0.15, 0.45, 7.0, 5.0, 0.3, 0),
    (0.45, 0.4, 11.0, 6.0, -0.7, 1),
    (0.75, 0.42, 9.0, 5.0, 0.5, 2),
    (0.05, 0.6, 8.0, 6.0, -0.3, 3),
    (0.3, 0.55, 10.0, 7.0, 0.6, 4),
    (0.6, 0.5, 12.0, 5.0, -0.4, 5),
    (0.88, 0.6, 8.0, 6.0, 0.7, 6),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in _pieces) {
      final paint = Paint()..color = _colors[p.$6].withValues(alpha: 0.85);
      canvas.save();
      canvas.translate(p.$1 * size.width, p.$2 * size.height);
      canvas.rotate(p.$5);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset.zero, width: p.$3, height: p.$4),
          const Radius.circular(2),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}
