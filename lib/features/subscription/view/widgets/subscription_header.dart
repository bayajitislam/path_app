import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/core/constants/app_images.dart';

class SubscriptionHeader extends StatelessWidget {
  const SubscriptionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Center(
          child: Image.asset(
            AppImages.appIcon,
            width: 120.w,
            height: 120.w,
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          'Upgrade to access premium features',
          textAlign: TextAlign.center,
          style: GoogleFonts.cinzel(
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
            height: 1.2,
            letterSpacing: 0,
            color: const Color(0xFF1A0E14),
          ),
        ),
      ],
    );
  }
}
