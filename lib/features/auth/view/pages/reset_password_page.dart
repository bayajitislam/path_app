import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/core/constants/app_images.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/widgets/primary_button.dart';
import 'package:path_app/routes/routes_name.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
                'Reset Your Password',
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
                'Password',
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
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
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
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                    child: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 20.r,
                      color: const Color(0xFF636363),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Re Type Password',
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
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  hintText: 'Re-enter your password',
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
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(
                        () =>
                            _obscureConfirmPassword = !_obscureConfirmPassword,
                      );
                    },
                    child: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 20.r,
                      color: const Color(0xFF636363),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              PrimaryButton(
                buttonName: 'Confirm',
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            size: 60.r,
                            color: AppPallete.primary,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Success!',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 18.sp,
                              color: const Color(0xFF1A0E14),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Your password has been reset successfully.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              color: const Color(0xFF636363),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                              Get.offAllNamed(RoutesName.auth);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppPallete.primary,
                              minimumSize: Size(double.infinity, 45.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Text(
                              'Continue to Login',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp,
                                color: AppPallete.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
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
