import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/features/home/constants/home_images.dart';
import 'package:path_app/routes/routes_name.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final VoidCallback? onLeafTap;
  final VoidCallback? onBellTap;

  const HomeAppBar({
    super.key,
    this.userName = 'Kieran',
    this.onLeafTap,
    this.onBellTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      height: preferredSize.height + statusBarHeight,
      decoration: const BoxDecoration(color: AppPallete.transparent),
      padding: EdgeInsets.only(top: statusBarHeight, left: 16, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: greeting
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hello, $userName',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Ready for a green shift?',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          // Leaf button
          _CircleIconButton(
            onTap: onLeafTap,
            borderColor: AppPallete.border,
            child: Image.asset(HomeImages.leaf, width: 22, height: 22),
          ),
          const SizedBox(width: 10),
          // Bell button
          _CircleIconButton(
            onTap: () => Get.toNamed(RoutesName.notification),
            borderColor: const Color(0xFFD1FAE5),
            child: Image.asset(HomeImages.notification, width: 22, height: 22),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? borderColor;

  const _CircleIconButton({required this.child, this.onTap, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppPallete.white,
          shape: BoxShape.circle,
          border: borderColor != null
              ? Border.all(color: borderColor!, width: 2)
              : null,
        ),
        child: Center(child: child),
      ),
    );
  }
}
