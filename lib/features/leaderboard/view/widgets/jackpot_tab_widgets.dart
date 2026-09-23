import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/core/theme/app_pallete.dart';

// ─── Pot Stats Row ────────────────────────────────────────────────────────────

/// Shimmering animated border gradient card matching PlayJackpotCard:
/// - Outer container with black background and subtle ambient glow
/// - Continuous 2s linear 360-degree rotating linear-gradient spinner beam (#fffa)
/// - Inset front layer with dark surface (rgba(5,5,5,1)) and golden radial ambient warmth
/// - Crisp white typography for high contrast jackpot stats
class JackpotPotStatsCard extends StatefulWidget {
  final double totalPot;
  final double prizePool;
  final int winners;
  final String currencySymbol;
  final double strokeWidth;
  final double borderRadius;
  final Duration shimmerDuration;

  const JackpotPotStatsCard({
    super.key,
    required this.totalPot,
    required this.prizePool,
    required this.winners,
    this.currencySymbol = '£',
    this.strokeWidth = 1.6,
    this.borderRadius = 16,
    this.shimmerDuration = const Duration(seconds: 2),
  });

  @override
  State<JackpotPotStatsCard> createState() => _JackpotPotStatsCardState();
}

class _JackpotPotStatsCardState extends State<JackpotPotStatsCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmerCtrl;

  @override
  void initState() {
    super.initState();
    _shimmerCtrl = AnimationController(
      vsync: this,
      duration: widget.shimmerDuration,
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = widget.borderRadius.r;
    final effectiveStroke = widget.strokeWidth.r;
    final innerRadius = math.max(0.0, effectiveRadius - effectiveStroke);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(effectiveRadius),
        boxShadow: [
          // Outer ambient white glow matching CSS box-shadow
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.35),
            blurRadius: 10,
            spreadRadius: -1,
          ),
          // Deep elevation shadow for card lift
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(effectiveRadius),
        child: Stack(
          children: [
            // ── Layer 1: Base Black Background ──
            Positioned.fill(child: const ColoredBox(color: Color(0xFF000000))),

            // ── Layer 2: Rotating Shimmer Gradient Beam (2s linear infinite) ──
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _shimmerCtrl,
                builder: (context, _) {
                  return CustomPaint(
                    painter: _CssSpinnerPainter(
                      angle: _shimmerCtrl.value * 2 * math.pi,
                    ),
                  );
                },
              ),
            ),

            // ── Layer 3: Front Layer Inset with Radial Ambience & Content ──
            Container(
              margin: EdgeInsets.all(effectiveStroke),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(innerRadius),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(innerRadius),
                child: CustomPaint(
                  painter: const _FrontLayerPainter(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _StatItem(
                          value:
                              '${widget.currencySymbol}${widget.totalPot.toStringAsFixed(0)}',
                          label: 'Total Pot',
                        ),
                        _StatItem(
                          value:
                              '${widget.currencySymbol}${widget.prizePool.toStringAsFixed(0)}',
                          label: 'Prize Pool',
                        ),
                        _StatItem(
                          value: '${widget.winners}',
                          label: 'Winners',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: -0.4,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: AppPallete.white.withValues(alpha: 0.92),
          ),
        ),
      ],
    );
  }
}

/// Exact reproduction of the CSS rotating linear-gradient spinner beam:
/// `linear-gradient(transparent, transparent 30%, #fffa, transparent 70%, transparent)`
class _CssSpinnerPainter extends CustomPainter {
  final double angle;

  const _CssSpinnerPainter({required this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final center = Offset(size.width / 2.0, size.height / 2.0);
    final diagonal =
        math.sqrt(size.width * size.width + size.height * size.height) * 1.3;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);

    final squareRect = Rect.fromCenter(
      center: Offset.zero,
      width: diagonal,
      height: diagonal,
    );

    final gradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.transparent,
        Colors.transparent,
        Color(0xFAFFFFFF), // #fffa bright white light beam
        Colors.transparent,
        Colors.transparent,
      ],
      stops: [0.0, 0.30, 0.50, 0.70, 1.0],
    );

    final paint = Paint()..shader = gradient.createShader(squareRect);
    canvas.drawRect(squareRect, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_CssSpinnerPainter oldDelegate) =>
      oldDelegate.angle != angle;
}

/// Paints the CSS front-layer background:
/// `radial-gradient(40% 50% at center 100%, rgba(255, 239, 206, 0.15), transparent),`
/// `radial-gradient(80% 100% at center 120%, rgba(255, 239, 204, 0.2), transparent),`
/// `rgba(5, 5, 5, 1);`
class _FrontLayerPainter extends CustomPainter {
  const _FrontLayerPainter();

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    final rect = Offset.zero & size;

    // 1. Base dark background rgba(5, 5, 5, 1)
    canvas.drawRect(rect, Paint()..color = const Color(0xFF050505));

    // 2. Radial Gradient 1: 80% 100% at center 120%, rgba(255, 239, 204, 0.2)
    final radial1 = Paint()
      ..shader = const RadialGradient(
        center: Alignment(0.0, 1.4),
        radius: 0.95,
        colors: [
          Color(0x33FFEFCC), // rgba(255, 239, 204, 0.20)
          Colors.transparent,
        ],
        stops: [0.0, 1.0],
      ).createShader(rect);
    canvas.drawRect(rect, radial1);

    // 3. Radial Gradient 2: 40% 50% at center 100%, rgba(255, 239, 206, 0.15)
    final radial2 = Paint()
      ..shader = const RadialGradient(
        center: Alignment(0.0, 1.0),
        radius: 0.55,
        colors: [
          Color(0x26FFECCE), // rgba(255, 239, 206, 0.15)
          Colors.transparent,
        ],
        stops: [0.0, 1.0],
      ).createShader(rect);
    canvas.drawRect(rect, radial2);

    // 4. Subtle top inset specular highlight matching CSS inset box shadow
    final topHighlightPaint = Paint()
      ..color = const Color(0x22FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    canvas.drawLine(
      Offset(12.w, 0.5),
      Offset(size.width - 12.w, 0.5),
      topHighlightPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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
    with TickerProviderStateMixin {
  late final AnimationController _barController;
  late final Animation<double> _barAnim;
  late final AnimationController _shimmerCtrl;

  @override
  void initState() {
    super.initState();
    _shimmerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();

    _barController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _barAnim = CurvedAnimation(parent: _barController, curve: Curves.easeOut);
    _barController.forward();
  }

  @override
  void dispose() {
    _shimmerCtrl.dispose();
    _barController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const effectiveRadius = 16.0;
    const effectiveStroke = 1.6;
    const innerRadius = effectiveRadius - effectiveStroke;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(effectiveRadius.r),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.28),
              blurRadius: 10,
              spreadRadius: -1,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(effectiveRadius.r),
          child: Stack(
            children: [
              // ── Layer 1: Base Black Background ──
              Positioned.fill(
                child: const ColoredBox(color: Color(0xFF000000)),
              ),

              // ── Layer 2: Rotating Shimmer Gradient Beam ──
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _shimmerCtrl,
                  builder: (context, _) {
                    return CustomPaint(
                      painter: _CssSpinnerPainter(
                        angle: _shimmerCtrl.value * 2 * math.pi,
                      ),
                    );
                  },
                ),
              ),

              // ── Layer 3: Front Layer Inset with Content ──
              Container(
                margin: EdgeInsets.all(effectiveStroke.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(innerRadius.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(innerRadius.r),
                  child: CustomPaint(
                    painter: const _FrontLayerPainter(),
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '🎉',
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    'Congratulations!',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0x2510B981),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: const Color(0x6010B981),
                                    width: 0.8,
                                  ),
                                ),
                                child: Text(
                                  '${widget.points} pts',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF34D399),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'You are Jackpot Eligible',
                                style: GoogleFonts.inter(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 12.sp,
                                ),
                              ),
                              Text(
                                '${widget.percentage.toStringAsFixed(0)}%',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF34D399),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),

                          // Sustainability score label
                          Text(
                            'Sustainability Score',
                            style: GoogleFonts.inter(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 6.h),

                          // Progress bar
                          AnimatedBuilder(
                            animation: _barAnim,
                            builder: (_, _) => ClipRRect(
                              borderRadius: BorderRadius.circular(4.r),
                              child: LinearProgressIndicator(
                                value:
                                    _barAnim.value * (widget.percentage / 100),
                                minHeight: 8.h,
                                backgroundColor: const Color(0xFF1E2923),
                                valueColor:
                                    const AlwaysStoppedAnimation<Color>(
                                  Color(0xFF10B981),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 14.h),

                          // Top % + Reward row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Top ${widget.topPercent}',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    'This Week',
                                    style: GoogleFonts.inter(
                                      color:
                                          Colors.white.withValues(alpha: 0.6),
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '\$${widget.estimatedReward.toStringAsFixed(0)}',
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFFBBF24),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    'Estimated Reward',
                                    style: GoogleFonts.inter(
                                      color:
                                          Colors.white.withValues(alpha: 0.6),
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Divider(
                            height: 1,
                            color: Colors.white.withValues(alpha: 0.12),
                          ),
                          SizedBox(height: 12.h),

                          // Eligible to
                          Text(
                            'Eligible to',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          ...widget.eligibleTo.map(
                            (e) => Padding(
                              padding: EdgeInsets.only(bottom: 6.h),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(2.r),
                                    decoration: const BoxDecoration(
                                      color: Color(0x2010B981),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check_rounded,
                                      size: 13.sp,
                                      color: const Color(0xFF34D399),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    e,
                                    style: GoogleFonts.inter(
                                      color:
                                          Colors.white.withValues(alpha: 0.85),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (widget.nextUnlock != null) ...[
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Text(
                                  '🔥',
                                  style: TextStyle(fontSize: 13.sp),
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  widget.nextUnlock!,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFFFBBF24),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _fadeAnim;
  late final AnimationController _shimmerCtrl;

  @override
  void initState() {
    super.initState();
    _shimmerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();

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
    _shimmerCtrl.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const effectiveRadius = 20.0;
    const effectiveStroke = 1.6;
    const innerRadius = effectiveRadius - effectiveStroke;

    return FadeTransition(
      opacity: _fadeAnim,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(effectiveRadius.r),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.28),
              blurRadius: 10,
              spreadRadius: -1,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(effectiveRadius.r),
          child: Stack(
            children: [
              // ── Layer 1: Base Black Background ──
              Positioned.fill(
                child: const ColoredBox(color: Color(0xFF000000)),
              ),

              // ── Layer 2: Rotating Shimmer Gradient Beam ──
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _shimmerCtrl,
                  builder: (context, _) {
                    return CustomPaint(
                      painter: _CssSpinnerPainter(
                        angle: _shimmerCtrl.value * 2 * math.pi,
                      ),
                    );
                  },
                ),
              ),

              // ── Layer 3: Front Layer Inset with Content ──
              Container(
                margin: EdgeInsets.all(effectiveStroke.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(innerRadius.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(innerRadius.r),
                  child: CustomPaint(
                    painter: const _FrontLayerPainter(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 32.h,
                        horizontal: 24.w,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '🎉',
                                style: TextStyle(fontSize: 18.sp),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Congratulations!',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF34D399),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'Your Rank',
                            style: GoogleFonts.inter(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          ScaleTransition(
                            scale: _scaleAnim,
                            child: Text(
                              '#${widget.rank}',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 34.sp,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -1,
                                shadows: [
                                  Shadow(
                                    color: const Color(0xFF10B981)
                                        .withValues(alpha: 0.6),
                                    blurRadius: 12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0x2510B981),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: const Color(0x6010B981),
                                width: 0.8,
                              ),
                            ),
                            child: Text(
                              'Top ${widget.topPercent}',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF34D399),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

