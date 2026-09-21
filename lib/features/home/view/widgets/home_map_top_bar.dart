import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_app/core/constants/app_images.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/routes/routes_name.dart';

/// Top bar for the Home Map screen with logo on left, and Leaf & Notification buttons on right.
class HomeMapTopBar extends StatelessWidget {
  final VoidCallback? onLeafTap;

  const HomeMapTopBar({
    super.key,
    this.onLeafTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: App Icon Badge
          Container(
            width: 48.r,
            height: 48.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.6),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.asset(
                "assets/app/app_logo.png",
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Right: Action Buttons (Leaf & Bell)
          Row(
            children: [
              // Leaf Action Button
              _CircularActionButton(
                onTap: onLeafTap ??
                    () {
                      // Navigate or show sustainability / eco status
                    },
                child: Image.asset(
                  AppImages.leaf,
                  width: 22.r,
                  height: 22.r,
                ),
              ),
              SizedBox(width: 12.w),

              // Notification Bell Button
              _CircularActionButton(
                onTap: () => Get.toNamed(RoutesName.notification),
                child: Image.asset(
                  AppImages.bell,
                  width: 20.r,
                  height: 20.r,
                  color: const Color(0xFF34C759),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CircularActionButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const _CircularActionButton({
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44.r,
        height: 44.r,
        decoration: BoxDecoration(
          color: AppPallete.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.14),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}
