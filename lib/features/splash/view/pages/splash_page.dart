import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_app/core/constants/app_images.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/routes/routes_name.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _buttonsController;

  late Animation<Offset> _logoSlide;
  late Animation<double> _logoFade;
  late Animation<Offset> _buttonsSlide;
  late Animation<double> _buttonsFade;

  @override
  void initState() {
    super.initState();

    // Logo slides from top → down
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _logoSlide = Tween<Offset>(begin: const Offset(0, -1.2), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _logoController, curve: Curves.easeOutCubic),
        );

    _logoFade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeIn));

    // Buttons slide from bottom → up
    _buttonsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _buttonsSlide = Tween<Offset>(begin: const Offset(0, 1.2), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _buttonsController,
            curve: Curves.easeOutCubic,
          ),
        );

    _buttonsFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _buttonsController, curve: Curves.easeIn),
    );

    _logoController.forward();
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _buttonsController.forward();
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _buttonsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Twinkling star background
          const _StarField(),

          // Subtle radial vignette
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.2,
                colors: [Colors.transparent, Colors.black.withAlpha(160)],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          SizedBox(height: 160.h),

                          // Logo + text: slides top → down
                          SlideTransition(
                            position: _logoSlide,
                            child: FadeTransition(
                              opacity: _logoFade,
                              child: Column(
                                children: [
                                  Image.asset(
                                    AppImages.appIcon,
                                    width: 120.w,
                                    height: 120.w,
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(
                                    'Path',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 36.sp,
                                      height: 40.sp / 36.sp,
                                      letterSpacing: -0.9.sp,
                                      color: AppPallete.white,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'Choose your world',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18.sp,
                                      height: 1.4,
                                      letterSpacing: 0,
                                      color: const Color(0xFFD1FAE5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const Spacer(),

                          // Buttons: slide bottom → up
                          SlideTransition(
                            position: _buttonsSlide,
                            child: FadeTransition(
                              opacity: _buttonsFade,
                              child: Column(
                                children: [
                                  _GetStartedButton(),
                                  SizedBox(height: 16.h),
                                  _LoginButton(),
                                  SizedBox(height: 60.h),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────
// Star field
// ────────────────────────────────────────────────────
class _StarField extends StatefulWidget {
  const _StarField();

  @override
  State<_StarField> createState() => _StarFieldState();
}

class _StarFieldState extends State<_StarField>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late List<_Star> _stars;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    _stars = List.generate(120, (_) => _Star());
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (ctx, _) => CustomPaint(
        painter: _StarPainter(_stars, _ctrl.value),
        size: Size.infinite,
      ),
    );
  }
}

class _Star {
  final double x;
  final double y;
  final double baseRadius;
  final double phase;
  final double rotation; // unique angle per sparkle
  final bool isSparkle; // larger ones are full sparkles, tiny ones are dots

  _Star()
    : x = Random().nextDouble(),
      y = Random().nextDouble(),
      baseRadius = Random().nextDouble() * 5 + 0.8,
      phase = Random().nextDouble(),
      rotation = Random().nextDouble() * pi / 4,
      isSparkle = Random().nextDouble() > 0.35;
}

class _StarPainter extends CustomPainter {
  final List<_Star> stars;
  final double t;

  _StarPainter(this.stars, this.t);

  // Draws a 4-pointed sparkle (✦) path centred at [cx, cy] with outer
  // radius [outer] and inner radius [inner], rotated by [angle] radians.
  void _drawSparkle(
    Canvas canvas,
    Paint paint,
    double cx,
    double cy,
    double outer,
    double inner,
    double angle,
  ) {
    final path = Path();
    for (int i = 0; i < 8; i++) {
      final r = i.isEven ? outer : inner;
      final a = angle + i * pi / 4;
      final x = cx + r * cos(a);
      final y = cy + r * sin(a);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final s in stars) {
      final twinkle = (sin((t + s.phase) * pi * 2) + 1) / 2;
      final opacity = 0.2 + twinkle * 0.8;
      final r = s.baseRadius * (0.65 + twinkle * 0.5);
      final cx = s.x * size.width;
      final cy = s.y * size.height;

      paint.color = Colors.white.withValues(alpha: opacity);

      if (s.isSparkle) {
        // 4-pointed sparkle shape
        _drawSparkle(canvas, paint, cx, cy, r, r * 0.22, s.rotation);

        // Soft glow halo for the sparkle
        paint.color = Colors.white.withValues(alpha: opacity * 0.18);
        _drawSparkle(canvas, paint, cx, cy, r * 2.6, r * 0.6, s.rotation);
      } else {
        // Tiny accent dot
        canvas.drawCircle(Offset(cx, cy), r * 0.4, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_StarPainter old) => true;
}

// ────────────────────────────────────────────────────
// Buttons
// ────────────────────────────────────────────────────
class _GetStartedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SizedBox(
          width: double.infinity,
          height: 49.h,
          child: ElevatedButton(
            onPressed: () => Get.toNamed(RoutesName.onboarding),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2A2A2A),
              padding: EdgeInsets.symmetric(vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
                side: BorderSide(color: Colors.white.withAlpha(30), width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Get Started',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    height: 1.0,
                    color: AppPallete.primary,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14.sp,
                  color: AppPallete.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SizedBox(
          width: double.infinity,
          height: 49.h,
          child: ElevatedButton(
            onPressed: () => Get.toNamed(RoutesName.auth),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppPallete.primary,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              'Log in',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                height: 1.0,
                color: AppPallete.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
