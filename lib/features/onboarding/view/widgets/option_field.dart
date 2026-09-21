import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/core/theme/app_pallete.dart';

/// A premium selectable option card featuring an **ultra-clean animated gradient border**
/// and an atmospheric outer neon glow that radiates strictly outward, keeping the card
/// interior crisp, clean, and pristine.
class OptionField extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  /// Duration of the selection transition.
  final Duration animationDuration;

  /// Easing curve for the selection transition.
  final Curve animationCurve;

  /// Speed of one full rotation cycle (default: 3 seconds).
  final Duration rotationDuration;

  /// Colors along the rotating gradient border.
  final List<Color>? gradientColors;

  /// Card corner radius (default: pill shape, 333.r).
  final double? borderRadius;

  /// Border stroke thickness when active.
  final double borderWidth;

  const OptionField({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
    this.animationDuration = const Duration(milliseconds: 280),
    this.animationCurve = Curves.easeInOutCubic,
    this.rotationDuration = const Duration(seconds: 3),
    this.gradientColors,
    this.borderRadius,
    this.borderWidth = 1,
  });

  @override
  State<OptionField> createState() => _OptionFieldState();
}

class _OptionFieldState extends State<OptionField>
    with TickerProviderStateMixin {
  late final AnimationController _selectionCtrl;
  late final Animation<double> _selectionAnim;
  late final AnimationController _rotationCtrl;

  static const Color _unselectedBorder = Color(0xFFE5E7EB);

  // High-contrast, vibrant liquid neon gradient
  static const List<Color> _defaultGradientColors = [
    Color(0xFF00E5FF), // Electric Cyan
    Color(0xFF34C759), // Path Signature Green
    Color(0xFF00E676), // Bright Mint
    Color(0xFF4AB9E6), // Vivid Teal
    Color(0xFF00E5FF), // Seamless loop
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
      curve: widget.animationCurve,
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
  void didUpdateWidget(OptionField old) {
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
    final effectiveRadius = widget.borderRadius ?? 333.r;
    final colors = widget.gradientColors ?? _defaultGradientColors;

    return Center(
      child: SizedBox(
        width: 346.w,
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
                  // ── Layer 1: Ethereal Outer Glow (BEHIND card, zero inside bleed) ──
                  if (t > 0)
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _OuterGlowPainter(
                          angle: angle,
                          selectionProgress: t,
                          borderRadius: effectiveRadius,
                          borderWidth: widget.borderWidth,
                          colors: colors,
                        ),
                      ),
                    ),

                  // ── Layer 2: Clean White Card Surface ────────────────────────────
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                      vertical: 12.h,
                    ),
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
                    child: child,
                  ),

                  // ── Layer 3: Razor-Sharp Crisp Animated Border Stroke ─────────────
                  Positioned.fill(
                    child: IgnorePointer(
                      child: CustomPaint(
                        painter: _CrispBorderPainter(
                          angle: angle,
                          selectionProgress: t,
                          borderRadius: effectiveRadius,
                          activeBorderWidth: widget.borderWidth,
                          idleBorderWidth: 1.2.w,
                          idleColor: _unselectedBorder,
                          colors: colors,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            child: Row(
              children: [
                // Animated Radio Indicator with smooth gradient fill
                AnimatedBuilder(
                  animation: _selectionAnim,
                  builder: (context, _) {
                    final t = _selectionAnim.value;
                    return Container(
                      width: 22.r,
                      height: 22.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: t > 0
                            ? LinearGradient(
                                colors: [
                                  const Color(0xFF00E5FF).withValues(alpha: t),
                                  const Color(0xFF34C759).withValues(alpha: t),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : null,
                        border: Border.all(
                          color: Color.lerp(
                            _unselectedBorder,
                            Colors.transparent,
                            t,
                          )!,
                          width: 1.5.w,
                        ),
                      ),
                      child: AnimatedSwitcher(
                        duration: widget.animationDuration,
                        child: widget.isSelected
                            ? Icon(
                                Icons.check,
                                key: const ValueKey('check'),
                                size: 13.sp,
                                color: AppPallete.white,
                              )
                            : const SizedBox.shrink(key: ValueKey('empty')),
                      ),
                    );
                  },
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          height: 1.0,
                          letterSpacing: -0.2.sp,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        widget.subtitle,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          height: 1.1,
                          letterSpacing: 0,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Renders a multi-layered atmospheric ambient aura strictly behind the card.
class _OuterGlowPainter extends CustomPainter {
  final double angle;
  final double selectionProgress;
  final double borderRadius;
  final double borderWidth;
  final List<Color> colors;

  _OuterGlowPainter({
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

    // Aspect-ratio normalized sweep rotation
    final aspect = size.width / max(1.0, size.height);
    final transform = _PillSweepTransform(angle, aspect);

    final sweepGradient = SweepGradient(
      center: Alignment.center,
      startAngle: 0.0,
      endAngle: 2 * pi,
      colors: colors
          .map((c) => c.withValues(alpha: c.a * selectionProgress))
          .toList(),
      transform: transform,
    );

    // Pass 2: Intense tighter inner aura
    final tightAuraPaint = Paint()
      ..shader = sweepGradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth + 1.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.0);
    canvas.drawRRect(rrect, tightAuraPaint);
  }

  @override
  bool shouldRepaint(_OuterGlowPainter old) =>
      old.angle != angle ||
      old.selectionProgress != selectionProgress ||
      old.borderWidth != borderWidth;
}

/// Renders the crisp, perfectly anti-aliased border stroke on top of the card edge.
class _CrispBorderPainter extends CustomPainter {
  final double angle;
  final double selectionProgress;
  final double borderRadius;
  final double activeBorderWidth;
  final double idleBorderWidth;
  final Color idleColor;
  final List<Color> colors;

  _CrispBorderPainter({
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

    // 1. Unselected crisp border pass
    if (selectionProgress < 1.0) {
      final idleAlpha = (1.0 - selectionProgress);
      final idlePaint = Paint()
        ..color = idleColor.withValues(alpha: idleAlpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = idleBorderWidth;
      canvas.drawRRect(rrect, idlePaint);
    }

    // 2. Animated active gradient border pass
    if (selectionProgress > 0.0) {
      final aspect = size.width / max(1.0, size.height);
      final transform = _PillSweepTransform(angle, aspect);

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
  bool shouldRepaint(_CrispBorderPainter old) =>
      old.angle != angle ||
      old.selectionProgress != selectionProgress ||
      old.activeBorderWidth != activeBorderWidth ||
      old.borderRadius != borderRadius;
}

/// Aspect-ratio compensator so the gradient flows at a uniform speed
/// across long horizontal sides without crowding in the pill corners.
class _PillSweepTransform extends GradientTransform {
  final double angle;
  final double aspect;

  const _PillSweepTransform(this.angle, this.aspect);

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
