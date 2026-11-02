import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/core/constants/app_images.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/routes/routes_name.dart';

/// Top bar for the Home Map screen with logo and animated Path title on left,
/// and Leaf & Notification buttons on right.
class HomeMapTopBar extends StatelessWidget {
  final VoidCallback? onLeafTap;
  final String title;

  const HomeMapTopBar({
    super.key,
    this.onLeafTap,
    this.title = 'Path',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: App Icon Badge & Animated Bold Title
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 48.r,
                height: 48.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.6),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Image.asset(
                    "assets/app/app_logo.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12.w),

              // Animated Title on logo's right side, vertically centered
              _AnimatedPathTitle(title: title),
            ],
          ),

          // Right: Action Buttons (Leaf & Bell)
          Row(
            children: [
              // Leaf Action Button
              _CircularActionButton(
                onTap: onLeafTap ??
                    () {
                      // Navigate or show sustainability / eco status
                    },
                child: Image.asset(
                  AppImages.leaf,
                  width: 22.r,
                  height: 22.r,
                ),
              ),
              SizedBox(width: 12.w),

              // Notification Bell Button
              _CircularActionButton(
                onTap: () => Get.toNamed(RoutesName.notification),
                child: Image.asset(
                  AppImages.bell,
                  width: 20.r,
                  height: 20.r,
                  color: const Color(0xFF34C759),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Animated bold title widget where an emerald green & mint light wave smoothly
/// sweeps and overlaps the solid bold white text in a continuous loop.
class _AnimatedPathTitle extends StatefulWidget {
  final String title;

  const _AnimatedPathTitle({required this.title});

  @override
  State<_AnimatedPathTitle> createState() => _AnimatedPathTitleState();
}

class _AnimatedPathTitleState extends State<_AnimatedPathTitle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = _controller.value;
        // Sweeps horizontally from left (-1.8) to right (+1.8)
        final startX = -1.8 + (3.6 * t);
        final endX = startX + 1.1;

        return Stack(
          alignment: Alignment.center,
          children: [
            // 1. Base Layer: Solid, bold white text with deep shadow
            Text(
              widget.title,
              style: GoogleFonts.inter(
                fontSize: 28.sp,
                fontWeight: FontWeight.w900,
                color: AppPallete.white,
                letterSpacing: -0.5,
                shadows: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),

            // 2. Overlapping Animated Color Layer: Vibrant emerald/mint color overlapping the text
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment(startX, -0.3),
                  end: Alignment(endX, 0.3),
                  colors: const [
                    Colors.transparent,
                    Color(0x3334C759),
                    Color(0xFF34C759),
                    Color(0xFF6EE7B7),
                    Color(0xFF34C759),
                    Color(0x3334C759),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.2, 0.4, 0.5, 0.6, 0.8, 1.0],
                ).createShader(bounds);
              },
              child: Text(
                widget.title,
                style: GoogleFonts.inter(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF34C759),
                  letterSpacing: -0.5,
                  shadows: [
                    BoxShadow(
                      color: const Color(0xFF34C759).withValues(alpha: 0.8),
                      blurRadius: 16,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CircularActionButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const _CircularActionButton({
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44.r,
        height: 44.r,
        decoration: BoxDecoration(
          color: AppPallete.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.14),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}
