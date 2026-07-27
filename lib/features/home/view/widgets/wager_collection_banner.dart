import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class WagerCollectionBanner extends StatelessWidget {
  final String message;
  final String title;
  final Color titleColor;
  final Color messageColor;
  final Color backgroundColor;
  final Color borderColor;

  const WagerCollectionBanner({
    super.key,
    this.title = 'Automated Wager Collection',
    this.message =
        '£10.00 will be automatically deducted every Sunday for the weekly competitions.',
    this.titleColor = const Color(0xFF78350F),
    this.messageColor = const Color(0xFFB45309),
    this.backgroundColor = const Color(0xFFFFFBEB),
    this.borderColor = const Color(0xFFFEF3C7),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // £ icon
          Padding(
            padding: EdgeInsets.only(top: 1),
            child: Text(
              '£',
              style: AppTextStyle.s14w4i(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF78350F),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.s14w4i(
                    fontWeight: FontWeight.w700,
                    color: titleColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(message, style: AppTextStyle.s12w4i(color: messageColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
