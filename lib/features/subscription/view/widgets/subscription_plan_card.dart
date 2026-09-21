import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/core/theme/app_pallete.dart';

class SubscriptionPlan {
  final String icon;
  final String title;
  final String subtitle;
  final String price;
  final String? saveBadge;

  const SubscriptionPlan({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.price,
    this.saveBadge,
  });
}

/// Selectable subscription plan card featuring:
/// - An intense tight inner aura (4px) + soft wide diffuse halo (10px) behind the card.
/// - A crisp 360-degree rotating gradient border.
/// - Clean white interior with zero glow bleed.
class SubscriptionPlanCard extends StatefulWidget {
  final SubscriptionPlan plan;
  final bool isSelected;
  final VoidCallback onTap;
  final Duration animationDuration;
  final Duration rotationDuration;
  final double borderRadius;
  final double borderWidth;

  const SubscriptionPlanCard({
    super.key,
    required this.plan,
    required this.isSelected,
    required this.onTap,
    this.animationDuration = const Duration(milliseconds: 260),
    this.rotationDuration = const Duration(seconds: 3),
    this.borderRadius = 16,
    this.borderWidth = 1.2,
  });

  @override
  State<SubscriptionPlanCard> createState() => _SubscriptionPlanCardState();
}

class _SubscriptionPlanCardState extends State<SubscriptionPlanCard>
    with TickerProviderStateMixin {
  late final AnimationController _selectionCtrl;
  late final Animation<double> _selectionAnim;
  late final AnimationController _rotationCtrl;

  static const Color _unselectedBorder = Color(0xFFE5E7EB);

  // Vibrant neon gradient: Electric Cyan -> Signature Green -> Mint -> Vivid Teal
  static const List<Color> _gradientColors = [
    Color(0xFF00E5FF),
    Color(0xFF34C759),
    Color(0xFF00E676),
    Color(0xFF4AB9E6),
    Color(0xFF00E5FF),
  ];

  @override
  void initState() {
    super.initState();

    _selectionCtrl = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
      value: widget.isSelected ? 1.0 : 0.0,
    );
    _selectionAnim = CurvedAnimation(
      parent: _selectionCtrl,
      curve: Curves.easeInOutCubic,
    );

    _rotationCtrl = AnimationController(
      vsync: this,
      duration: widget.rotationDuration,
    );

    if (widget.isSelected) {
      _rotationCtrl.repeat();
    }
  }

  @override
  void didUpdateWidget(SubscriptionPlanCard old) {
    super.didUpdateWidget(old);
    if (widget.isSelected != old.isSelected) {
      if (widget.isSelected) {
        if (!_rotationCtrl.isAnimating) {
          _rotationCtrl.repeat();
        }
        _selectionCtrl.forward();
      } else {
        _selectionCtrl.reverse().then((_) {
          if (!widget.isSelected && mounted) {
            _rotationCtrl.stop();
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _selectionCtrl.dispose();
    _rotationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = widget.borderRadius.r;

    return Padding(
      padding: EdgeInsets.only(
        top: widget.plan.saveBadge != null ? 10.h : 0,
        bottom: 12.h,
      ),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedBuilder(
          animation: Listenable.merge([_selectionAnim, _rotationCtrl]),
          builder: (context, child) {
            final t = _selectionAnim.value;
            final angle = _rotationCtrl.value * 2 * pi;

            return Stack(
              clipBehavior: Clip.none,
              children: [
                // ── Layer 1: Intense tight aura (4px) + soft wide halo (10px) BEHIND card ──
                if (t > 0)
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _PlanOuterGlowPainter(
                        angle: angle,
                        selectionProgress: t,
                        borderRadius: effectiveRadius,
                        borderWidth: widget.borderWidth,
                        colors: _gradientColors,
                      ),
                    ),
                  ),

                // ── Layer 2: Clean White Card Surface (blocks inner glow bleed) ──
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: AppPallete.white,
                    borderRadius: BorderRadius.circular(effectiveRadius),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        widget.plan.icon,
                        width: 33.w,
                        height: 33.w,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.plan.title,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                                height: 1.0,
                                letterSpacing: 0,
                                color: const Color(0xFF1A0E14),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              widget.plan.subtitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                height: 1.4,
                                letterSpacing: 0,
                                color: const Color(0xFF636363),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        widget.plan.price,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          height: 1.0,
                          letterSpacing: 0,
                          color: const Color(0xFF34C759),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Layer 3: Crisp Animated Border Stroke ──
                Positioned.fill(
                  child: IgnorePointer(
                    child: CustomPaint(
                      painter: _PlanCrispBorderPainter(
                        angle: angle,
                        selectionProgress: t,
                        borderRadius: effectiveRadius,
                        activeBorderWidth: widget.borderWidth,
                        idleBorderWidth: 1.0,
                        idleColor: _unselectedBorder,
                        colors: _gradientColors,
                      ),
                    ),
                  ),
                ),

                // ── Layer 4: Save Badge (if present & active) ──
                if (widget.plan.saveBadge != null && t > 0)
                  Positioned(
                    top: -10.h,
                    right: 12.w,
                    child: Opacity(
                      opacity: t,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF00E5FF), Color(0xFF34C759)],
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF34C759).withValues(alpha: 0.35 * t),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          widget.plan.saveBadge!,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 11.sp,
                            height: 1.0,
                            letterSpacing: 0,
                            color: AppPallete.white,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Renders the dual-pass glow behind the card:
/// 1. Intense tight inner aura (4px)
/// 2. Soft wide diffuse halo (10px)
class _PlanOuterGlowPainter extends CustomPainter {
  final double angle;
  final double selectionProgress;
  final double borderRadius;
  final double borderWidth;
  final List<Color> colors;

  _PlanOuterGlowPainter({
    required this.angle,
    required this.selectionProgress,
    required this.borderRadius,
    required this.borderWidth,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (selectionProgress <= 0) return;

    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    final aspect = size.width / max(1.0, size.height);
    final transform = _CardSweepTransform(angle, aspect);

    final sweepGradient = SweepGradient(
      center: Alignment.center,
      startAngle: 0.0,
      endAngle: 2 * pi,
      colors: colors
          .map((c) => c.withValues(alpha: c.a * selectionProgress))
          .toList(),
      transform: transform,
    );


    // Pass 2: Intense tight inner aura (4px blur)
    final tightAuraPaint = Paint()
      ..shader = sweepGradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth 
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);
    canvas.drawRRect(rrect, tightAuraPaint);
  }

  @override
  bool shouldRepaint(_PlanOuterGlowPainter old) =>
      old.angle != angle ||
      old.selectionProgress != selectionProgress ||
      old.borderWidth != borderWidth;
}

/// Renders the razor-sharp border stroke on top of the card edge.
class _PlanCrispBorderPainter extends CustomPainter {
  final double angle;
  final double selectionProgress;
  final double borderRadius;
  final double activeBorderWidth;
  final double idleBorderWidth;
  final Color idleColor;
  final List<Color> colors;

  _PlanCrispBorderPainter({
    required this.angle,
    required this.selectionProgress,
    required this.borderRadius,
    required this.activeBorderWidth,
    required this.idleBorderWidth,
    required this.idleColor,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final currentWidth = lerpDouble(
      idleBorderWidth,
      activeBorderWidth,
      selectionProgress,
    )!;

    final half = currentWidth / 2;
    final strokeRect = Rect.fromLTWH(
      half,
      half,
      size.width - currentWidth,
      size.height - currentWidth,
    );

    final clampedRadius = max(0.0, borderRadius - half);
    final rrect = RRect.fromRectAndRadius(
      strokeRect,
      Radius.circular(clampedRadius),
    );

    // 1. Idle border pass
    if (selectionProgress < 1.0) {
      final idleAlpha = (1.0 - selectionProgress);
      final idlePaint = Paint()
        ..color = idleColor.withValues(alpha: idleAlpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = idleBorderWidth;
      canvas.drawRRect(rrect, idlePaint);
    }

    // 2. Active rotating gradient border pass
    if (selectionProgress > 0.0) {
      final aspect = size.width / max(1.0, size.height);
      final transform = _CardSweepTransform(angle, aspect);

      final sweepGradient = SweepGradient(
        center: Alignment.center,
        startAngle: 0.0,
        endAngle: 2 * pi,
        colors: colors
            .map((c) => c.withValues(alpha: c.a * selectionProgress))
            .toList(),
        transform: transform,
      );

      final borderPaint = Paint()
        ..shader = sweepGradient.createShader(Offset.zero & size)
        ..style = PaintingStyle.stroke
        ..strokeWidth = currentWidth;

      canvas.drawRRect(rrect, borderPaint);
    }
  }

  @override
  bool shouldRepaint(_PlanCrispBorderPainter old) =>
      old.angle != angle ||
      old.selectionProgress != selectionProgress ||
      old.activeBorderWidth != activeBorderWidth ||
      old.borderRadius != borderRadius;
}

/// Normalizes sweep rotation speed to remain uniform on rectangular cards.
class _CardSweepTransform extends GradientTransform {
  final double angle;
  final double aspect;

  const _CardSweepTransform(this.angle, this.aspect);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final c = bounds.center;
    return Matrix4.identity()
      ..translate(c.dx, c.dy)
      ..scale(1.0, 1.0 / sqrt(aspect))
      ..rotateZ(angle)
      ..scale(1.0, sqrt(aspect))
      ..translate(-c.dx, -c.dy);
  }
}
