import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/core/constants/app_images.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_button.dart';
import 'package:path_app/routes/routes_name.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLogin = true;
  bool _obscurePassword = true;
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      resizeToAvoidBottomInset: true,
      body: AppBg(
        child: SafeArea(
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
                _AuthToggle(
                  isLogin: _isLogin,
                  onToggle: (value) {
                    setState(() {
                      _isLogin = value;
                      _hasError = false;
                    });
                  },
                ),
                SizedBox(height: 32.h),
                if (_isLogin) ...[
                  _buildLabel('Email Address'),
                  SizedBox(height: 8.h),
                  _buildField(
                    hintText: 'Enter your email',
                    hintColor: const Color(0xFF636363),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildLabel('Password'),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RoutesName.forgotPassword);
                        },
                        child: Text(
                          'Forgot Password?',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            height: 1.4,
                            letterSpacing: -0.01,
                            color: AppPallete.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  _buildPasswordField(
                    obscureText: _obscurePassword,
                    hintText: 'Enter your password',
                    onToggle: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                  if (_hasError) ...[
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
                          'Please enter correct password',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            height: 1.25,
                            letterSpacing: 0,
                            color: const Color(0xFFDC2626),
                          ),
                        ),
                      ],
                    ),
                  ],
                ] else ...[
                  _buildLabel('Full Name'),
                  SizedBox(height: 8.h),
                  _buildField(
                    hintText: 'Jhon Doe',
                    hintColor: const Color(0xFF636363),
                  ),
                  SizedBox(height: 20.h),
                  _buildLabel('Email Address'),
                  SizedBox(height: 8.h),
                  _buildField(
                    hintText: 'Rhebhek@gmail.com',
                    hintColor: const Color(0xFF636363),
                  ),
                  SizedBox(height: 20.h),
                  _buildLabel('Password'),
                  SizedBox(height: 8.h),
                  _buildPasswordField(
                    obscureText: _obscurePassword,
                    hintText: 'Enter your password',
                    onToggle: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                  SizedBox(height: 20.h),
                  _buildLabel('Re Type Password'),
                  SizedBox(height: 8.h),
                  _buildPasswordField(
                    obscureText: _obscurePassword,
                    hintText: 'Re-enter your password',
                    onToggle: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                  SizedBox(height: 20.h),
                  _buildLabel('Delivery Platform'),
                  SizedBox(height: 8.h),
                  _buildDropdown(),
                ],
                SizedBox(height: 24.h),
                PrimaryButton(
                  buttonName: _isLogin ? 'Login' : 'Sign Up',
                  onPressed: () {
                    if (_isLogin) {
                      Get.offNamedUntil(
                        arguments: {'isFromProfile': false},
                        RoutesName.subscription,
                        (route) => false,
                      );
                    } else {
                      Get.toNamed(RoutesName.otp);
                    }
                  },
                ),
                SizedBox(height: 16.h),
                if (!_isLogin)
                  Center(
                    child: Text(
                      'By clicking the "sign up" button, you accept the terms of the Privacy Policy.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        height: 1.0,
                        letterSpacing: 0,
                        color: const Color(0xFF636363),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                SizedBox(height: 60.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        height: 1.4,
        letterSpacing: 0,
        color: const Color(0xFF636363),
      ),
    );
  }

  Widget _buildField({required String hintText, required Color hintColor}) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
          color: hintColor,
          height: 1.0,
          letterSpacing: 0,
        ),
        filled: true,
        fillColor: AppPallete.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: const BorderSide(color: Color(0xFFE7E8E7), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: const BorderSide(color: Color(0xFFE7E8E7), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: const BorderSide(color: Color(0xFFE7E8E7), width: 1),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
      ),
    );
  }

  Widget _buildPasswordField({
    required bool obscureText,
    required String hintText,
    required VoidCallback onToggle,
  }) {
    return TextField(
      obscureText: obscureText,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        hintText: hintText,
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
          borderSide: const BorderSide(color: Color(0xFFE7E8E7), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: const BorderSide(color: Color(0xFFE7E8E7), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: const BorderSide(color: Color(0xFFE7E8E7), width: 1),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
        suffixIcon: GestureDetector(
          onTap: onToggle,
          child: Icon(
            obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            size: 20.r,
            color: const Color(0xFF636363),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    String? selectedPlatform;

    final List<String> platforms = [
      'Uber',
      'Lyft',
      'DoorDash',
      'Instacart',
      'Other',
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppPallete.white,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: const Color(0xFFE7E8E7), width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          initialValue: selectedPlatform,
          hint: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              'Select Platform (Optional)',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: const Color(0xFF636363),
                height: 1.0,
                letterSpacing: 0,
              ),
            ),
          ),
          icon: Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 20.r,
              color: const Color(0xFF636363),
            ),
          ),
          borderRadius: BorderRadius.circular(6.r),
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: const Color(0xFF1A0E14),
            height: 1.0,
            letterSpacing: 0,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 11.h,
            ),
          ),
          items: platforms
              .map(
                (platform) =>
                    DropdownMenuItem(value: platform, child: Text(platform)),
              )
              .toList(),
          onChanged: (value) {
            setState(() => selectedPlatform = value);
          },
        ),
      ),
    );
  }
}

class _AuthToggle extends StatelessWidget {
  final bool isLogin;
  final ValueChanged<bool> onToggle;

  const _AuthToggle({required this.isLogin, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 345.w,
      height: 45.h,
      decoration: BoxDecoration(
        color: AppPallete.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: isLogin ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: 345.w / 2 - 5.w,
              height: 37.h,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                color: AppPallete.secondary,
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: const Color(0xFFE7E8E7), width: 1),
              ),
            ),
          ),
          Row(
            children: [
              _buildTab('Login', isLogin, () => onToggle(true)),
              _buildTab('Sign Up', !isLogin, () => onToggle(false)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String label, bool isActive, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 45.h,
          color: Colors.transparent,
          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                height: 1.0,
                letterSpacing: 0,
                color: isActive
                    ? const Color(0xFF1A0E14)
                    : const Color(0xFF636363),
              ),
              child: Text(label),
            ),
          ),
        ),
      ),
    );
  }
}
