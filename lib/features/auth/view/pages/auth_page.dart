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
  String _errorMessage = 'Please enter correct password';
  String? _selectedPlatform;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleAuthSubmit() {
    setState(() => _hasError = false);
    if (_isLogin) {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      if (email.isEmpty) {
        setState(() {
          _hasError = true;
          _errorMessage = 'Please enter your email address';
        });
        return;
      }
      if (!GetUtils.isEmail(email)) {
        setState(() {
          _hasError = true;
          _errorMessage = 'Please enter a valid email address';
        });
        return;
      }
      if (password.isEmpty) {
        setState(() {
          _hasError = true;
          _errorMessage = 'Please enter your password';
        });
        return;
      }

      Get.offNamedUntil(
        RoutesName.subscription,
        (route) => false,
        arguments: {'isFromProfile': false},
      );
    } else {
      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text;
      final confirmPassword = _confirmPasswordController.text;

      if (name.isEmpty) {
        setState(() {
          _hasError = true;
          _errorMessage = 'Please enter your full name';
        });
        return;
      }
      if (email.isEmpty || !GetUtils.isEmail(email)) {
        setState(() {
          _hasError = true;
          _errorMessage = 'Please enter a valid email address';
        });
        return;
      }
      if (password.length < 6) {
        setState(() {
          _hasError = true;
          _errorMessage = 'Password must be at least 6 characters';
        });
        return;
      }
      if (password != confirmPassword) {
        setState(() {
          _hasError = true;
          _errorMessage = 'Passwords do not match';
        });
        return;
      }

      Get.toNamed(RoutesName.otp);
    }
  }

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
                    controller: _emailController,
                    hintText: 'Enter your email',
                    hintColor: const Color(0xFF636363),
                    keyboardType: TextInputType.emailAddress,
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
                    controller: _passwordController,
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
                        Expanded(
                          child: Text(
                            _errorMessage,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              height: 1.25,
                              letterSpacing: 0,
                              color: const Color(0xFFDC2626),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ] else ...[
                  _buildLabel('Full Name'),
                  SizedBox(height: 8.h),
                  _buildField(
                    controller: _nameController,
                    hintText: 'John Doe',
                    hintColor: const Color(0xFF636363),
                  ),
                  SizedBox(height: 20.h),
                  _buildLabel('Email Address'),
                  SizedBox(height: 8.h),
                  _buildField(
                    controller: _emailController,
                    hintText: 'john@example.com',
                    hintColor: const Color(0xFF636363),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20.h),
                  _buildLabel('Password'),
                  SizedBox(height: 8.h),
                  _buildPasswordField(
                    controller: _passwordController,
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
                    controller: _confirmPasswordController,
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
                        Expanded(
                          child: Text(
                            _errorMessage,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              height: 1.25,
                              letterSpacing: 0,
                              color: const Color(0xFFDC2626),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
                SizedBox(height: 24.h),
                PrimaryButton(
                  buttonName: _isLogin ? 'Login' : 'Sign Up',
                  onPressed: _handleAuthSubmit,
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

  Widget _buildField({
    required String hintText,
    required Color hintColor,
    TextEditingController? controller,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
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
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
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
    final List<String> platforms = const [
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
          initialValue: _selectedPlatform,
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
            setState(() => _selectedPlatform = value);
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
