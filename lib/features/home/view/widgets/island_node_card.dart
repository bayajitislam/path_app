import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// A premium glassmorphic floating action card positioned over an island on the home map.
/// Features high-sigma backdrop blur, specular light gradient border, and soft ambient shadow.
class IslandNodeCard extends StatefulWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;
  final double? width;
  final double? height;

  const IslandNodeCard({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
    this.width,
    this.height,
  });

  @override
  State<IslandNodeCard> createState() => _IslandNodeCardState();
}

class _IslandNodeCardState extends State<IslandNodeCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pressCtrl;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _pressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.93).animate(
      CurvedAnimation(parent: _pressCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cardWidth = widget.width ?? 98.w;
    final cardHeight = widget.height ?? 86.h;
    final borderRadius = BorderRadius.circular(26.r);

    return GestureDetector(
      onTapDown: (_) => _pressCtrl.forward(),
      onTapUp: (_) {
        _pressCtrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _pressCtrl.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnim,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnim.value,
          child: child,
        ),
        child: Container(
          width: cardWidth,
          height: cardHeight,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: CustomPaint(
                foregroundPainter: _GlassBorderPainter(
                  radius: 26.r,
                  strokeWidth: 1,
                ),
                child: Container(
                  width: cardWidth,
                  height: cardHeight,
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    color: Colors.white.withValues(alpha: 0.01),
                    // gradient: LinearGradient(
                    //   colors: [
                    //     Colors.white.withValues(alpha: 0.001),
                    //     Colors.white.withValues(alpha: 0.001),
                    //   ],
                    //   begin: Alignment.topLeft,
                    //   end: Alignment.bottomRight,
                    // ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        widget.iconPath,
                        width: 36.w,
                        height: 32.h,
                        fit: BoxFit.contain,
                        // color: Colors.white,
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        widget.title,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          height: 1.1,
                          letterSpacing: 0.1,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom painter that draws a specular gradient border along the rounded rectangle
class _GlassBorderPainter extends CustomPainter {
  final double radius;
  final double strokeWidth;

  _GlassBorderPainter({required this.radius, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xF2FFFFFF), // 95% crisp white reflection at top-left
          Color(0x8CFFFFFF), // 55% white at sides
          Color(0x40FFFFFF), // 25% subtle white reflection at bottom-right
        ],
        stops: [0.0, 0.45, 1.0],
      ).createShader(rect);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant _GlassBorderPainter oldDelegate) =>
      oldDelegate.radius != radius || oldDelegate.strokeWidth != strokeWidth;
}
