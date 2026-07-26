import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/core/constants/app_images.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/widgets/primary_button.dart';
import 'package:path_app/routes/routes_name.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h),
              Center(
                child: Image.asset(
                  AppImages.appIcon,
                  width: 120.w,
                  height: 120.w,
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                'Forget Password',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  height: 1.2,
                  letterSpacing: 0,
                  color: const Color(0xFF1A0E14),
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                'Email Address',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  height: 1.4,
                  letterSpacing: 0,
                  color: const Color(0xFF636363),
                ),
              ),
              SizedBox(height: 8.h),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Rhebhek@gmail.com',
                  hintStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: const Color(0xFF636363),
                    height: 1.0,
                    letterSpacing: 0,
                  ),
                  filled: true,
                  fillColor: AppPallete.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.r),
                    borderSide: const BorderSide(
                      color: Color(0xFFE7E8E7),
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.r),
                    borderSide: const BorderSide(
                      color: Color(0xFFE7E8E7),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.r),
                    borderSide: const BorderSide(
                      color: Color(0xFFE7E8E7),
                      width: 1,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 11.h,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              PrimaryButton(
                buttonName: 'Send OTP',
                onPressed: () {
                  Get.toNamed(RoutesName.otp);
                },
              ),
              SizedBox(height: 60.h),
            ],
          ),
        ),
      ),
    );
  }
}
