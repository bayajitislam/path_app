import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/core/theme/app_pallete.dart';

class DeliveryHistoryTile extends StatelessWidget {
  final String dateTime;
  final int ecoPoints;
  final String startLabel;
  final String dropoffLabel;
  final double distanceKm;
  final int durationMin;
  final double co2Saved;
  final VoidCallback? onTap;

  const DeliveryHistoryTile({
    super.key,
    required this.dateTime,
    required this.ecoPoints,
    required this.startLabel,
    required this.dropoffLabel,
    required this.distanceKm,
    required this.durationMin,
    required this.co2Saved,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppPallete.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Row 1: Date + Eco Points badge ─────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 15,
                      color: AppPallete.secondaryText,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      dateTime,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppPallete.primaryText,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECFDF5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '+$ecoPoints Eco Points',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF059669),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Divider(height: 1, color: Color(0xFFF0F0F0)),
            const SizedBox(height: 12),

            // ── Row 2: Start → Dropoff route ───────────────────
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Left: dot + line + dot
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Grey start dot
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFBDBDBD),
                          border: Border.all(
                            color: const Color(0xFFBDBDBD),
                            width: 1.5,
                          ),
                        ),
                      ),
                      // Dashed vertical line
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Center(
                            child: CustomPaint(
                              size: const Size(1.5, double.infinity),
                              painter: _DashedLinePainter(),
                            ),
                          ),
                        ),
                      ),
                      // Green dropoff dot
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppPallete.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 14),

                  // Right: labels
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Start
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start',
                              style: TextStyle(
                                fontFamily: GoogleFonts.inter().fontFamily,
                                fontSize: 12,
                                color: AppPallete.secondaryText,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              startLabel,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppPallete.primaryText,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Dropoff
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dropoff',
                              style: TextStyle(
                                fontFamily: GoogleFonts.inter().fontFamily,
                                fontSize: 12,
                                color: AppPallete.secondaryText,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              dropoffLabel,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppPallete.primaryText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14),

            // ── Row 3: Distance · Duration · CO2 ───────────────
            Row(
              children: [
                // Distance
                Image.asset(
                  'assets/icons/route.png',
                  width: 16,
                  height: 16,
                  color: AppPallete.secondaryText,
                  errorBuilder: (_, _, _) => const Icon(
                    Icons.route_outlined,
                    size: 16,
                    color: AppPallete.secondaryText,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  '${distanceKm.toStringAsFixed(1)} km',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppPallete.secondaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 14),
                // Duration
                const Icon(
                  Icons.access_time_rounded,
                  size: 15,
                  color: AppPallete.secondaryText,
                ),
                const SizedBox(width: 5),
                Text(
                  '$durationMin min',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppPallete.secondaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 14),
                // CO2
                Image.asset(
                  'assets/icons/leaf.png',
                  width: 16,
                  height: 16,
                  color: Color(0xFF059669),
                  errorBuilder: (_, _, _) => const Icon(
                    Icons.eco_outlined,
                    size: 16,
                    color: Color(0xFF059669),
                  ),
                ),
                const SizedBox(width: 5),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF059669),
                    ),
                    children: [
                      TextSpan(text: '${co2Saved.toStringAsFixed(1)}kg CO'),
                      const TextSpan(text: '₂', style: TextStyle(fontSize: 10)),
                      const TextSpan(text: ' saved'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Dashed Line Painter ──────────────────────────────────────────────────────

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dashHeight = 4.0;
    const dashSpace = 3.0;
    final paint = Paint()
      ..color = const Color(0xFFBDBDBD)
      ..strokeWidth = 1.5;

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}
