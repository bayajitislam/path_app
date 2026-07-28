import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_app/core/constants/app_images.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/routes/routes_name.dart';

class JoinLobbyPage extends StatefulWidget {
  final String playerName;
  final String matchName;
  final double amount;
  final String? avatarUrl;

  const JoinLobbyPage({
    super.key,
    this.playerName = 'Maya Osei',
    this.matchName = 'Eco Sprint',
    this.amount = 250,
    this.avatarUrl,
  });

  @override
  State<JoinLobbyPage> createState() => _JoinLobbyPageState();
}

class _JoinLobbyPageState extends State<JoinLobbyPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
    _scaleAnim = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );

    _fadeController.forward();
    _scaleController.forward();

    // Auto navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      if (mounted) Get.offAndToNamed(RoutesName.hostMatch);
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ── Gradient background ──────────────────────────────
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.appBackground),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // ── Confetti ─────────────────────────────────────────
          const _ConfettiLayer(),

          // ── Content ──────────────────────────────────────────
          FadeTransition(
            opacity: _fadeAnim,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Avatar with green ring
                  ScaleTransition(
                    scale: _scaleAnim,
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppPallete.primary, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: AppPallete.primary.withValues(alpha: 0.3),
                            blurRadius: 16,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: widget.avatarUrl != null
                            ? Image.network(
                                widget.avatarUrl!,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                color: const Color(0xFF2A2A3A),
                                child: Center(
                                  child: Text(
                                    widget.playerName.isNotEmpty
                                        ? widget.playerName[0]
                                        : '?',
                                    style: const TextStyle(
                                      color: AppPallete.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // You're in!
                  const Text(
                    "You're in!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: AppPallete.primaryText,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Subtitle
                  Text(
                    "Joined ${widget.playerName}'s ${widget.matchName} for \$${widget.amount.toStringAsFixed(0)}.\nRace starts when the lobby fills.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppPallete.secondaryText,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Cancel button
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: AppPallete.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppPallete.primaryText,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Confetti Layer ───────────────────────────────────────────────────────────

class _ConfettiLayer extends StatefulWidget {
  const _ConfettiLayer();

  @override
  State<_ConfettiLayer> createState() => _ConfettiLayerState();
}

class _ConfettiLayerState extends State<_ConfettiLayer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_ConfettiPiece> _pieces = [];
  final Random _rng = Random();

  static const _colors = [
    Color(0xFFFF6B6B),
    Color(0xFFFFD93D),
    Color(0xFF6BCB77),
    Color(0xFF4D96FF),
    Color(0xFFFF6BB5),
    Color(0xFF00C9A7),
    Color(0xFFFF922B),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() => setState(() {}));

    // Generate pieces
    for (int i = 0; i < 60; i++) {
      _pieces.add(
        _ConfettiPiece(
          x: _rng.nextDouble(),
          y: _rng.nextDouble() * 0.7,
          width: 8 + _rng.nextDouble() * 10,
          height: 5 + _rng.nextDouble() * 6,
          color: _colors[_rng.nextInt(_colors.length)],
          speed: 0.15 + _rng.nextDouble() * 0.2,
          angle: _rng.nextDouble() * pi * 2,
          rotationSpeed: (_rng.nextDouble() - 0.5) * 4,
          delay: _rng.nextDouble() * 0.5,
        ),
      );
    }

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final t = _controller.value;

    return SizedBox.expand(
      child: CustomPaint(painter: _ConfettiPainter(_pieces, t, size)),
    );
  }
}

class _ConfettiPiece {
  final double x;
  final double y;
  final double width;
  final double height;
  final Color color;
  final double speed;
  final double angle;
  final double rotationSpeed;
  final double delay;

  const _ConfettiPiece({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.color,
    required this.speed,
    required this.angle,
    required this.rotationSpeed,
    required this.delay,
  });
}

class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiPiece> pieces;
  final double t;
  final Size screenSize;

  const _ConfettiPainter(this.pieces, this.t, this.screenSize);

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in pieces) {
      final progress = ((t - p.delay) / (1 - p.delay)).clamp(0.0, 1.0);
      if (progress <= 0) continue;

      final dx = p.x * size.width;
      final dy = (p.y + progress * p.speed * 3) * size.height;
      final rotation = p.angle + progress * p.rotationSpeed * pi * 2;

      final paint = Paint()
        ..color = p.color.withValues(alpha: 1 - progress * 0.4);

      canvas.save();
      canvas.translate(dx, dy);
      canvas.rotate(rotation);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset.zero,
            width: p.width,
            height: p.height,
          ),
          const Radius.circular(2),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter old) => old.t != t;
}
