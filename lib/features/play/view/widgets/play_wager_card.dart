import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:path_app/core/constants/app_images.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';
import 'package:path_app/routes/routes_name.dart';

/// Interactive Wager Card with Diagonal Surface Gloss Sweep (Holographic / Card Sheen):
/// - Each card starts at a random time offset so cards never flash together
/// - Smooth 28° holographic sweep with sparkling apex highlight
/// - Random pause (2s to 5s) between sweeps so cards remain naturally desynchronized
class PlayWagerCard extends StatefulWidget {
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
  final int? cardIndex;
  final Duration sweepDuration;

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
    this.cardIndex,
    this.sweepDuration = const Duration(milliseconds: 1800),
  });

  @override
  State<PlayWagerCard> createState() => _PlayWagerCardState();
}

class _PlayWagerCardState extends State<PlayWagerCard>
    with SingleTickerProviderStateMixin {
  static int _instanceSeed = 0;

  late final AnimationController _sheenCtrl;
  final math.Random _rnd = math.Random();
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _sheenCtrl = AnimationController(
      vsync: this,
      duration: widget.sweepDuration,
    );

    _scheduleNextSweep(isInitial: true);
  }

  void _scheduleNextSweep({bool isInitial = false}) async {
    if (!mounted || _isDisposed) return;

    final index = widget.cardIndex ?? (_instanceSeed++);
    // Random initial delay so cards start at completely different times
    final int delayMs = isInitial
        ? (300 + (index * 1100) + _rnd.nextInt(1200)) // e.g. Card 0: ~0.8s, Card 1: ~2.1s, etc.
        : (2000 + _rnd.nextInt(3200)); // Subsequent random pauses: 2.0s to 5.2s

    await Future.delayed(Duration(milliseconds: delayMs));
    if (!mounted || _isDisposed) return;

    _sheenCtrl.forward(from: 0.0).then((_) {
      if (!mounted || _isDisposed) return;
      _scheduleNextSweep(isInitial: false);
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _sheenCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppPallete.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
          BoxShadow(
            color: const Color(0xFF34C759).withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // ── Card Content ──
            Padding(
              padding: const EdgeInsets.all(16),
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
                        backgroundImage: widget.avatarUrl != null
                            ? NetworkImage(widget.avatarUrl!)
                            : null,
                        child: widget.avatarUrl == null
                            ? Text(
                                widget.playerName.isNotEmpty
                                    ? widget.playerName[0]
                                    : '?',
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
                              widget.playerName,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppPallete.primaryText,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.playerRank,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppPallete.secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Share/info icons
                      const Icon(
                        Icons.link,
                        size: 20,
                        color: AppPallete.secondaryText,
                      ),
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
                          border: Border.all(
                            color: const Color(0xFFF5C451),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              AppImages.coinIcon,
                              width: 12,
                              height: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.playerPoints}',
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
                        label: widget.mode,
                        color: const Color(0xFFD9F7E8),
                        textColor: AppPallete.primary,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppPallete.border),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              AppImages.linkedicon,
                              width: 12,
                              height: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.distanceKm.toStringAsFixed(0)} km',
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
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
                              '${widget.distanceKm.toStringAsFixed(1)} km · ${widget.locationLabel}',
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
                        '${widget.reward} reward',
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
                        '${widget.slotsUsed}/${widget.slotsTotal}',
                        style: AppTextStyle.s14w7sora(
                          color: AppPallete.secondaryText,
                        ).copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      const Spacer(),
                      // Play button
                      GestureDetector(
                        onTap: widget.onPlay ??
                            () => Get.toNamed(RoutesName.joinLobby),
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
                              const SizedBox(width: 6),
                              const Text(
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
            ),

            // ── Diagonal Surface Gloss Sweep (Holographic / Card Sheen) ──
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: _sheenCtrl,
                  builder: (context, _) {
                    if (_sheenCtrl.value <= 0.0 || _sheenCtrl.value >= 1.0) {
                      return const SizedBox.shrink();
                    }
                    return CustomPaint(
                      painter: _DiagonalGlossPainter(
                        progress: _sheenCtrl.value,
                        borderRadius: 16,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
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

/// Paints the diagonal gloss sheen sweeping smoothly across the card surface:
/// - 28-degree diagonal angle
/// - Core glossy specular band with soft holographic falloffs
class _DiagonalGlossPainter extends CustomPainter {
  final double progress;
  final double borderRadius;

  const _DiagonalGlossPainter({
    required this.progress,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final t = Curves.easeInOutCubic.transform(progress);

    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(borderRadius),
    );

    canvas.save();
    canvas.clipRRect(rrect);

    // Diagonal dimension
    final diagonal =
        math.sqrt(size.width * size.width + size.height * size.height);
    final beamWidth = diagonal * 0.42;

    // Angle: 28 degrees
    final angle = 28.0 * (math.pi / 180.0);

    // Center and rotate canvas
    canvas.translate(size.width / 2.0, size.height / 2.0);
    canvas.rotate(-angle);

    // Travel along X in the rotated coordinate space
    final totalSpan = diagonal + beamWidth * 2.2;
    final rotX = -totalSpan / 2.0 + totalSpan * t;

    final beamRect = Rect.fromLTRB(
      rotX - beamWidth / 2.0,
      -diagonal,
      rotX + beamWidth / 2.0,
      diagonal,
    );

    final sheenShader = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: const [
        Colors.transparent,
        Color(0x0534C759),
        Color(0x20FFFFFF),
        Color(0x65FFFFFF), // High-clarity gloss band
        Color(0x95FFFFFF), // Sparkling holographic apex slit
        Color(0x65FFFFFF),
        Color(0x20FFFFFF),
        Color(0x0534C759),
        Colors.transparent,
      ],
      stops: const [
        0.0,
        0.18,
        0.36,
        0.47,
        0.50,
        0.53,
        0.64,
        0.82,
        1.0,
      ],
    ).createShader(beamRect);

    final sheenPaint = Paint()..shader = sheenShader;
    canvas.drawRect(beamRect, sheenPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_DiagonalGlossPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
