import 'package:flutter/material.dart';
import 'package:path_app/core/constants/app_images.dart';
import 'package:path_app/core/theme/app_pallete.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onBellTap;
  final bool showBackButton;

  const PrimaryAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    this.onBellTap,
    this.showBackButton = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final canPop = Navigator.of(context).canPop();
    final displayBack = showBackButton && canPop;

    return Container(
      height: preferredSize.height + statusBarHeight,
      decoration: const BoxDecoration(color: AppPallete.transparent),
      padding: EdgeInsets.only(top: statusBarHeight, left: 16, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title + subtitle with optional back button inline
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Back + title on same row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (displayBack) ...[
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(
                          Icons.chevron_left,
                          size: 24,
                          color: AppPallete.primaryText,
                        ),
                      ),
                      const SizedBox(width: 4),
                    ],
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppPallete.primaryText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppPallete.secondaryText,
                  ),
                ),
              ],
            ),
          ),

          // Bell button
          GestureDetector(
            onTap: onBellTap,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppPallete.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppPallete.primary.withValues(alpha: 0.75),
                  width: 1,
                ),
              ),
              //image
              child: Center(
                child: Image.asset(AppImages.bell, width: 20, height: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
