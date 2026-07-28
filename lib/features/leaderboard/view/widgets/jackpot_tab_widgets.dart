import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

// ─── Pot Stats Row ────────────────────────────────────────────────────────────

class JackpotPotStatsCard extends StatelessWidget {
  final double totalPot;
  final double prizePool;
  final int winners;
  final String currencySymbol;

  const JackpotPotStatsCard({
    super.key,
    required this.totalPot,
    required this.prizePool,
    required this.winners,
    this.currencySymbol = '£',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Color(0x80FFFBEB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x80FEF3C7)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _StatItem(
            value: '$currencySymbol${totalPot.toStringAsFixed(0)}',
            label: 'Total Pot',
          ),
          _StatItem(
            value: '$currencySymbol${prizePool.toStringAsFixed(0)}',
            label: 'Prize Pool',
          ),
          _StatItem(value: '$winners', label: 'Winners'),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppPallete.primaryText,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppPallete.secondaryText),
        ),
      ],
    );
  }
}

// ─── Congratulations Card (Jackpot) ──────────────────────────────────────────

class JackpotCongratsCard extends StatefulWidget {
  final int points;
  final double percentage;
  final String topPercent;
  final double estimatedReward;
  final List<String> eligibleTo;
  final String? nextUnlock;
  final VoidCallback? onTap;

  const JackpotCongratsCard({
    super.key,
    required this.points,
    required this.percentage,
    required this.topPercent,
    required this.estimatedReward,
    required this.eligibleTo,
    this.nextUnlock,
    this.onTap,
  });

  @override
  State<JackpotCongratsCard> createState() => _JackpotCongratsCardState();
}

class _JackpotCongratsCardState extends State<JackpotCongratsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _barController;
  late Animation<double> _barAnim;

  @override
  void initState() {
    super.initState();
    _barController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _barAnim = CurvedAnimation(parent: _barController, curve: Curves.easeOut);
    _barController.forward();
  }

  @override
  void dispose() {
    _barController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppPallete.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('🎉', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 6),
                    Text(
                      'Congratulations!',
                      style: AppTextStyle.s14w4i().copyWith(
                        color: AppPallete.primaryText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${widget.points} pts',
                  style: AppTextStyle.s14w4i().copyWith(
                    color: const Color(0xFF059669),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'You are Jackpot Eligible',
                  style: AppTextStyle.s12w4i(color: AppPallete.secondaryText),
                ),
                Text(
                  '${widget.percentage.toStringAsFixed(0)}%',
                  style: AppTextStyle.s12w4i(color: AppPallete.secondaryText),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Sustainability score label
            Text(
              'Sustainability Score',
              style: AppTextStyle.s12w4i(color: AppPallete.secondaryText),
            ),
            const SizedBox(height: 6),

            // Progress bar
            AnimatedBuilder(
              animation: _barAnim,
              builder: (_, _) => ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: _barAnim.value * (widget.percentage / 100),
                  minHeight: 8,
                  backgroundColor: const Color(0xFFE0E0E0),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppPallete.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Top % + Reward row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Top ${widget.topPercent}',
                      style: AppTextStyle.s14w4i(
                        color: AppPallete.primaryText,
                      ).copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'This Week',
                      style: AppTextStyle.s12w4i(
                        color: AppPallete.secondaryText,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${widget.estimatedReward.toStringAsFixed(0)}',
                      style: AppTextStyle.s14w4i(
                        color: AppPallete.primaryText,
                      ).copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'Estimated Reward',
                      style: AppTextStyle.s12w4i(
                        color: AppPallete.secondaryText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Divider(height: 1, color: Color(0xFFEEEEEE)),
            const SizedBox(height: 12),

            // Eligible to
            Text(
              'Eligible to',
              style: AppTextStyle.s14w4i(
                color: AppPallete.primaryText,
              ).copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            ...widget.eligibleTo.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check,
                      size: 14,
                      color: AppPallete.primary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      e,
                      style: AppTextStyle.s12w4i(
                        color: AppPallete.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.nextUnlock != null) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  const Text('🔥', style: TextStyle(fontSize: 13)),
                  const SizedBox(width: 6),
                  Text(
                    widget.nextUnlock!,
                    style: AppTextStyle.s12w4i(color: AppPallete.secondaryText),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── Rank Reveal Card (shown after tap on congrats) ───────────────────────────

class JackpotRankRevealCard extends StatefulWidget {
  final int rank;
  final String topPercent;

  const JackpotRankRevealCard({
    super.key,
    required this.rank,
    required this.topPercent,
  });

  @override
  State<JackpotRankRevealCard> createState() => _JackpotRankRevealCardState();
}

class _JackpotRankRevealCardState extends State<JackpotRankRevealCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _scaleAnim = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        decoration: BoxDecoration(
          color: AppPallete.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('🎉', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 6),
                Text(
                  'Congratulations!',
                  style: AppTextStyle.s14w4i(
                    color: AppPallete.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Your Rank',
              style: AppTextStyle.s10w4i(
                color: AppPallete.primaryText,
              ),
            ),
            const SizedBox(height: 12),
            ScaleTransition(
              scale: _scaleAnim,
              child: Text(
                '#${widget.rank}',
                style: AppTextStyle.s24w7i(
                  color: const Color(0xFF059669)
                )
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Top ${widget.topPercent}',
              style: AppTextStyle.s10w4i(
                color: AppPallete.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
