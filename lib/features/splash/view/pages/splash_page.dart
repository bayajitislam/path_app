import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_app/core/constants/app_images.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/routes/routes_name.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.primary,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      SizedBox(height: 160.h),
                      Image.asset(
                        AppImages.appIcon,
                        width: 120.w,
                        height: 120.w,
                      ),
                      //  SizedBox(height: 4.h),
                      Text(
                        'Path',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 36.sp,
                          height: 40.sp / 36.sp,
                          letterSpacing: -0.9.sp,
                          color: AppPallete.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Choose your world',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 18.sp,
                          height: 1.4,
                          letterSpacing: 0,
                          color: const Color(0xFFD1FAE5),
                        ),
                      ),
                      const Spacer(),
                      _GetStartedButton(),
                      SizedBox(height: 16.h),
                      _LoginButton(),
                      SizedBox(height: 60.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _GetStartedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SizedBox(
          width: double.infinity,
          height: 49.h,
          child: ElevatedButton(
            onPressed: () => Get.toNamed(RoutesName.onboarding),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppPallete.white,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Get Started',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                    height: 1.0,
                    letterSpacing: 0,
                    color: AppPallete.primary,
                  ),
                ),
                SizedBox(width: 2.w),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                  color: AppPallete.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SizedBox(
          width: double.infinity,
          height: 49.h,
          child: OutlinedButton(
            onPressed: () => Get.toNamed(RoutesName.auth),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
              side: BorderSide(color: AppPallete.border),
              padding: EdgeInsets.symmetric(vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              'Login',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                height: 1.0,
                letterSpacing: 0,
                color: AppPallete.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
