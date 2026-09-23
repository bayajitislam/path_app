import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/core/theme/app_pallete.dart';

/// Shimmering animated border gradient card inspired by the CSS rotating spinner beam:
/// - Outer container with black background and subtle ambient glow
/// - Continuous 2s linear 360-degree rotating linear-gradient spinner beam (#fffa)
/// - Inset front layer with dark surface (rgba(5,5,5,1)) and golden radial ambient warmth
/// - Crisp white typography for high contrast jackpot stats
class PlayJackpotCard extends StatefulWidget {
  final double monthlyJackpot;
  final double weeklyJackpot;
  final double currentJackpot;
  final String currencySymbol;
  final double strokeWidth;
  final double borderRadius;
  final Duration shimmerDuration;

  const PlayJackpotCard({
    super.key,
    required this.monthlyJackpot,
    required this.weeklyJackpot,
    required this.currentJackpot,
    this.currencySymbol = '£',
    this.strokeWidth = 1.6,
    this.borderRadius = 16,
    this.shimmerDuration = const Duration(seconds: 2),
  });

  @override
  State<PlayJackpotCard> createState() => _PlayJackpotCardState();
}

class _PlayJackpotCardState extends State<PlayJackpotCard>
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

            // ── Layer 3: Front Layer Inset (0.125rem) with Radial Ambience & Content ──
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
                        _JackpotItem(
                          amount: widget.monthlyJackpot,
                          label: 'Monthly Jackpot',
                          currencySymbol: widget.currencySymbol,
                        ),
                        _JackpotItem(
                          amount: widget.weeklyJackpot,
                          label: 'Weekly Jackpot',
                          currencySymbol: widget.currencySymbol,
                        ),
                        _JackpotItem(
                          amount: widget.currentJackpot,
                          label: 'Current Jackpot',
                          currencySymbol: widget.currencySymbol,
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

class _JackpotItem extends StatelessWidget {
  final double amount;
  final String label;
  final String currencySymbol;

  const _JackpotItem({
    required this.amount,
    required this.label,
    required this.currencySymbol,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$currencySymbol${amount.toStringAsFixed(0)}',
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

    // CSS: linear-gradient(transparent, transparent 30%, #fffa, transparent 70%, transparent)
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
