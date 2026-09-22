import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';

class SecondaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final Color titleColor;
  final Color backButtonColor;

  const SecondaryAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.titleColor = AppPallete.primaryText,
    this.backButtonColor = AppPallete.primaryText,
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
                        child: Icon(Icons.chevron_left, size: 24, color: backButtonColor),
                      ),
                      const SizedBox(width: 4),
                    ],
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: titleColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
