import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/core/theme/app_pallete.dart';

/// Animated black-themed segmented tab filter matching PlayJackpotCard:
/// - 360-degree rotating linear-gradient shimmer beam (#fffa)
/// - Dark front layer surface (#050505) with subtle golden warmth
/// - Outer ambient glow & depth elevation shadow
/// - Smooth animated tab pill transition with emerald glowing accents
class LeaderboardTabFilter extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int>? onChanged;

  const LeaderboardTabFilter({
    super.key,
    this.selectedIndex = 0,
    this.onChanged,
  });

  @override
  State<LeaderboardTabFilter> createState() => _LeaderboardTabFilterState();
}

class _LeaderboardTabFilterState extends State<LeaderboardTabFilter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmerCtrl;

  static const _tabs = ['Career', 'Jackpot'];

  @override
  void initState() {
    super.initState();
    _shimmerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = 14.r;
    final effectiveStroke = 1.4.r;
    final innerRadius = math.max(0.0, effectiveRadius - effectiveStroke);

    return Container(
      height: 46.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(effectiveRadius),
        boxShadow: [
          // Outer ambient white glow matching CSS box-shadow
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.25),
            blurRadius: 10,
            spreadRadius: -1,
          ),
          // Deep elevation shadow
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
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
            Positioned.fill(
              child: const ColoredBox(color: Color(0xFF000000)),
            ),

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

            // ── Layer 3: Front Layer Inset with Radial Ambience & Tabs ──
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
                    padding: EdgeInsets.all(3.r),
                    child: Row(
                      children: List.generate(_tabs.length, (i) {
                        final isSelected = i == widget.selectedIndex;
                        return Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => widget.onChanged?.call(i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              curve: Curves.easeInOutCubic,
                              decoration: BoxDecoration(
                                gradient: isSelected
                                    ? LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          AppPallete.white.withValues(alpha: .03),
                                          AppPallete.white.withValues(alpha: .01),
                                        ],
                                      )
                                    : null,
                                color: isSelected ? null : Colors.transparent,
                                borderRadius: BorderRadius.circular(9.r),
                                border: isSelected
                                    ? Border.all(
                                        color: AppPallete.white.withValues(
                                          alpha: 0.11,
                                        ),
                                        width: 1,
                                      )
                                    : Border.all(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: AppPallete.white.withValues(
                                            alpha: 0.11,
                                          ),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Center(
                                child: Text(
                                  _tabs[i],
                                  style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.white.withValues(alpha: 0.6),
                                    letterSpacing: -0.2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
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