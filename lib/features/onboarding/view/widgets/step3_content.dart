import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/core/theme/app_pallete.dart';

class Step3Content extends StatelessWidget {
  const Step3Content({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What should we call you?',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 28.sp,
              color: const Color(0xFF1A0E14),
              height: 1.2,
              letterSpacing: 0,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Connect your ride-sharing account by entering your profile.',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              color: const Color(0xFF636363),
              height: 1.5,
              letterSpacing: 0,
            ),
          ),
          SizedBox(height: 24.h),
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter your profile ID',
              hintStyle: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: const Color(0xFF636363),
                height: 1.0,
                letterSpacing: 0,
              ),
              filled: true,
              fillColor: AppPallete.secondary,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
