import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Exact Figma Cosmic Highway Painter with seamless top & bottom cosmic fade.
/// Faithful to the original Figma SVG coordinates (393 x 767 viewBox) with
/// smooth extensions so the road never abruptly cuts off when scrolling.
class CosmicRoadPainter extends CustomPainter {
  final List<Offset>? nodeCenters;
  final double? totalHeight;
  final double roadWidth;
  final double scrollOffset;
  final double viewportHeight;

  CosmicRoadPainter({
    this.nodeCenters,
    this.totalHeight,
    this.roadWidth = 105.0,
    this.scrollOffset = 0.0,
    this.viewportHeight = 0.0,
  });

  static const double svgWidth = 393.0;
  static const double svgHeight = 767.0;

  @override
  void paint(Canvas canvas, Size size) {
    final scaleX = size.width / svgWidth;
    final scaleY = size.height / svgHeight;

    canvas.save();
    canvas.scale(scaleX, scaleY);

    // Extended shader bounds to ensure gradient fades past the edges
    final shaderRect = const Rect.fromLTWH(0, -60.0, svgWidth, svgHeight + 140.0);

    // ── 1. The Exact Figma Road Boundary Path with Smooth Extensions ───
    final roadPath = _buildFigmaRoadPath();

    // ── 2. Outer Soft Highway Glow ─────────────────────────────
    final glowShader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: const [0.0, 0.06, 0.94, 1.0],
      colors: [
        Colors.transparent,
        const Color(0xFF419FD2).withValues(alpha: 0.35),
        const Color(0xFF419FD2).withValues(alpha: 0.35),
        Colors.transparent,
      ],
    ).createShader(shaderRect);

    final outerGlow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14.0
      ..shader = glowShader
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16);
    canvas.drawPath(roadPath, outerGlow);

    // ── 3. Road Body Fill (#223E63 with fade at top and bottom) ───
    final fillShader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: const [0.0, 0.06, 0.94, 1.0],
      colors: [
        Colors.transparent,
        const Color(0xFF223E63).withValues(alpha: 0.84),
        const Color(0xFF223E63).withValues(alpha: 0.84),
        Colors.transparent,
      ],
    ).createShader(shaderRect);

    final roadFill = Paint()
      ..style = PaintingStyle.fill
      ..shader = fillShader;
    canvas.drawPath(roadPath, roadFill);



    // ── 5. Crisp White Glowing Border Stroke ──────────────────
    final borderShader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: const [0.0, 0.06, 0.94, 1.0],
      colors: [
        Colors.transparent,
        Colors.white.withValues(alpha: 0.85),
        Colors.white.withValues(alpha: 0.85),
        Colors.transparent,
      ],
    ).createShader(shaderRect);

    final borderStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..shader = borderShader;
    canvas.drawPath(roadPath, borderStroke);

    canvas.restore(); // Exit scale

    // ── 6. Left-side Dashed Guide Line & Switcher Ring ────────
    _drawLeftGuideline(canvas, size);
  }

  /// Exact vector path translated directly from Figma SVG mask0_701_626
  /// with seamless top & bottom extensions to prevent abrupt cutoffs.
  Path _buildFigmaRoadPath() {
    final path = Path();
    path.moveTo(345.739, 438.403);

    // Bottom right sweep, extended smoothly past 765
    path.cubicTo(467.739, 539.903, 409.774, 695.027, 397.255, 765.903);
    path.cubicTo(390.0, 805.0, 380.0, 850.0, 365.0, 890.0);
    path.lineTo(105.0, 890.0);
    path.cubicTo(115.0, 845.0, 126.0, 800.0, 121.444, 765.903);

    // Highway ascent along left side
    path.cubicTo(149.981, 742.055, 204.551, 672.147, 194.536, 583.294);
    path.cubicTo(184.521, 494.441, 143.577, 462.314, 121.444, 438.403);
    path.cubicTo(91.0006, 405.513, 7.38464, 352.836, 14.2391, 296.403);
    path.cubicTo(21.0935, 239.969, 93.9992, 203.321, 126.978, 191.814);
    path.cubicTo(144.478, 185.708, 163.354, 163.125, 164.0, 144.314);
    path.cubicTo(164.646, 125.503, 142.727, 102.191, 126.978, 92.6852);

    // Top left sweep, extended smoothly past 0
    path.cubicTo(126.978, 92.6852, 22.5, 17.814, 22.5, 17.814);
    path.cubicTo(15.0, 10.0, 4.0, -15.0, -8.0, -45.0);
    path.lineTo(40.0, -35.0);
    path.cubicTo(52.0, -10.0, 62.0, 5.0, 70.5, 14.314);

    // Descent down the right flank back to anchor
    path.cubicTo(153.553, 62.676, 209.233, 75.074, 245.739, 94.6852);
    path.cubicTo(282.245, 114.297, 284.003, 151.727, 277.739, 166.402);
    path.cubicTo(249.812, 209.416, 169.161, 226.246, 180.775, 281.314);
    path.cubicTo(187.781, 314.533, 279.119, 382.977, 345.739, 438.403);
    path.close();
    return path;
  }



  void _drawLeftGuideline(Canvas canvas, Size size) {
    final scaleX = size.width / svgWidth;
    final scaleY = size.height / svgHeight;

    final dashPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..color = Colors.white.withValues(alpha: 0.35);

    // ── 1. Horizontal top tick (x: 2.0 -> 46.0 at y: 450.32) ──
    const tickY = 450.32;
    const tickStartX = 2.0;
    const tickEndX = 46.0;
    const dashLength = 8.0;
    const dashGap = 6.0;

    double curX = tickStartX;
    while (curX < tickEndX) {
      final nextX = math.min(curX + dashLength, tickEndX);
      canvas.drawLine(
        Offset(curX * scaleX, tickY * scaleY),
        Offset(nextX * scaleX, tickY * scaleY),
        dashPaint,
      );
      curX += dashLength + dashGap;
    }

    // ── 2. Vertical dashed line (x: 23.5 from y: 449.31 to y: 722.33) ──
    const lineX = 23.5;
    const lineStartY = 449.31;
    const lineEndY = 722.33;

    double curY = lineStartY;
    while (curY < lineEndY) {
      final nextY = math.min(curY + dashLength, lineEndY);
      canvas.drawLine(
        Offset(lineX * scaleX, curY * scaleY),
        Offset(lineX * scaleX, nextY * scaleY),
        dashPaint,
      );
      curY += dashLength + dashGap;
    }

    // ── 3. Faint circular dashed arc around the bottom-left switcher ring ──
    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.white.withValues(alpha: 0.22);

    final circleCenter = Offset(64.0 * scaleX, 624.31 * scaleY);
    final circleRadius = 31.5 * scaleX;

    final arcPath = Path()
      ..addArc(
        Rect.fromCircle(center: circleCenter, radius: circleRadius + 8.0),
        -math.pi * 0.70,
        math.pi * 1.4,
      );

    for (final metric in arcPath.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        final next = math.min(distance + 5.0, metric.length);
        final extract = metric.extractPath(distance, next);
        canvas.drawPath(extract, arcPaint);
        distance += 5.0 + 5.0;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CosmicRoadPainter oldDelegate) =>
      oldDelegate.scrollOffset != scrollOffset ||
      oldDelegate.viewportHeight != viewportHeight;
}
