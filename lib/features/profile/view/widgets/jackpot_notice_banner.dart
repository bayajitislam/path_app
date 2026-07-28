import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class JackpotNoticeBanner extends StatelessWidget {
  const JackpotNoticeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0x80FFFBEB), // Very light yellow background
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFFEF3C7), // Soft yellow border
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Lightning Icon Badge
          Container(
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.only(top: 2),
            child: const Icon(
              Icons.bolt_rounded,
              color: Color(0xFFF5A623), // Warm yellow icon
              size: 20,
            ),
          ),
          const SizedBox(width: 8),

          // Text Message
          Expanded(
            child: Text(
              'Jackpot prizes are awarded weekly to top-tier eco scorers and appear as a separate payout in your competition results once settled.',
              style: AppTextStyle.s12w4i(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF92400E), // Dark yellow/brownish text
              ),
            ),
          ),
        ],
      ),
    );
  }
}
