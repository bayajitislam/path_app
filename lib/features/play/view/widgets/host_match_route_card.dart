import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class HostMatchRouteCard extends StatelessWidget {
  final String routeName;
  final String tag;
  final VoidCallback? onTap;

  const HostMatchRouteCard({
    super.key,
    required this.routeName,
    this.tag = 'Suggested',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Route',
          style: AppTextStyle.s14w7sora(
            color: AppPallete.primaryText,
          ).copyWith(fontWeight: FontWeight.w600, fontSize: 12),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppPallete.white,
              border: Border.all(color: AppPallete.border, width: 1),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Map preview area
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D1F12),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/map_preview.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                // Bottom label
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: AppPallete.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        routeName,
                        style: AppTextStyle.s14w7sora(
                          color: AppPallete.primaryText,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        tag,
                        style: AppTextStyle.s14w7sora(
                          color: const Color(0xFF7C948A),
                        ).copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
