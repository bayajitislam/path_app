import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Custom painter for semi-circular radial gauge arc on the Rank Detail page.
class RadialGaugePainter extends CustomPainter {
  final double progress; // 0.0 to 1.0
  final double strokeWidth;

  RadialGaugePainter({
    required this.progress,
    this.strokeWidth = 14.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.85);
    final radius = size.width * 0.42;

    const startAngle = math.pi; // 180 degrees (left horizontal)
    const sweepAngle = math.pi; // 180 degrees sweep (semi-circle arc over top)

    final rect = Rect.fromCircle(center: center, radius: radius);

    // 1. Background grey arc
    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFFE5E7EB).withValues(alpha: 0.6);

    canvas.drawArc(rect, startAngle, sweepAngle, false, trackPaint);

    // 2. Active gradient progress arc
    if (progress > 0) {
      final activePaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..shader = const LinearGradient(
          colors: [
            Color(0xFF34C759), // Green at start
            Color(0xFF00E5FF), // Cyan at peak
            Color(0xFF4AB9E6), // Light blue at end
          ],
        ).createShader(rect);

      canvas.drawArc(
        rect,
        startAngle,
        sweepAngle * progress.clamp(0.0, 1.0),
        false,
        activePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant RadialGaugePainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.strokeWidth != strokeWidth;
}
