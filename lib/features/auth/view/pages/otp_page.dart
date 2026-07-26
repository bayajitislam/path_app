import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/core/constants/app_images.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/widgets/primary_button.dart';
import 'package:path_app/routes/routes_name.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> _controllers = List.generate(
    5,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
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
                  'Enter Your OTP',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                    height: 1.2,
                    letterSpacing: 0,
                    color: const Color(0xFF1A0E14),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Enter Code',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    height: 1.4,
                    letterSpacing: 0.03,
                    color: const Color(0xFF636363),
                  ),
                ),
                SizedBox(height: 32.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (index) {
                    return _buildOtpField(index);
                  }),
                ),
                SizedBox(height: 32.h),
                PrimaryButton(
                  buttonName: 'Submit',
                  onPressed: () {
                    Get.toNamed(RoutesName.resetPassword);
                  },
                ),
                SizedBox(height: 60.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOtpField(int index) {
    return Container(
      width: 48.w,
      height: 48.h,
      decoration: BoxDecoration(
        color: AppPallete.white,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: const Color(0xFFE7E8E7), width: 1),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          hintText: '-',
          hintStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: const Color(0xFF636363),
            height: 1.0,
            letterSpacing: 0,
          ),
          filled: true,
          fillColor: AppPallete.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 11.h,
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 4) {
            _focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
            _controllers[index - 1].selection = TextSelection.fromPosition(
              TextPosition(offset: _controllers[index - 1].text.length),
            );
          }
        },
      ),
    );
  }
}
