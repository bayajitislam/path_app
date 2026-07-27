import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAll;

  const SectionHeader({super.key, required this.title, this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyle.s14w4i(
            color: AppPallete.primaryText,
          ).copyWith(fontWeight: FontWeight.w700),
        ),
        GestureDetector(
          onTap: onViewAll,
          child: Row(
            children: [
              Text(
                'View All',
                style: AppTextStyle.s12w4i(
                  color: const Color(0xFF059669),
                ).copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 2),
              const Icon(
                Icons.chevron_right,
                size: 16,
                color: Color(0xFF059669),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
