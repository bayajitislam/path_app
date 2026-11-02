import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/core/constants/app_images.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_button.dart';
import 'package:path_app/core/widgets/secondary_app_bar.dart';
import 'package:path_app/routes/routes_name.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSendOtp() {
    final email = _emailController.text.trim();
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      setState(() => _errorMessage = 'Please enter a valid email address');
      return;
    }
    setState(() => _errorMessage = null);
    Get.toNamed(RoutesName.otp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: const SecondaryAppBar(title: 'Forgot Password'),
      body: AppBg(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Center(
                  child: Image.asset(
                    AppImages.appIcon,
                    width: 120.w,
                    height: 120.w,
                  ),
                ),
                SizedBox(height: 32.h),
                Text(
                  'Forgot Password',
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
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'john@example.com',
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
                if (_errorMessage != null) ...[
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 16.r,
                        color: const Color(0xFFDC2626),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        _errorMessage!,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: const Color(0xFFDC2626),
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: 24.h),
                PrimaryButton(
                  buttonName: 'Send OTP',
                  onPressed: _handleSendOtp,
                ),
                SizedBox(height: 60.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
