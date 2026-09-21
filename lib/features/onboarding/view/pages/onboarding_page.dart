import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/features/onboarding/controllers/onboarding_controller.dart';
import 'package:path_app/features/onboarding/view/widgets/step1_content.dart';
import 'package:path_app/features/onboarding/view/widgets/step2_content.dart';
import 'package:path_app/features/onboarding/view/widgets/step3_content.dart';
import 'package:path_app/features/onboarding/view/widgets/step4_content.dart';
import 'package:path_app/features/onboarding/view/widgets/step_indicator.dart';
import 'package:path_app/routes/routes_name.dart';

class OnboardingPage extends GetView<OnboardingController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      body: AppBg(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Obx(() {
              final currentStep = controller.currentStep.value;

              return Column(
                children: [
                  // Header Section (Step Indicator & Counter)
                  SizedBox(height: 24.h),
                  StepIndicator(currentStep: currentStep, totalSteps: 4),
                  SizedBox(height: 14.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Step $currentStep of 4',
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                        color: const Color(0xFF636363),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Scrollable Step Content
                  Expanded(
                    child: PageView(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        controller.currentStep.value = index + 1;
                      },
                      children: [
                        const Step1Content(),
                        Step2Content(controller: controller),
                        const Step3Content(),
                        Step4Content(controller: controller),
                      ],
                    ),
                  ),

                  // Navigation Buttons at Bottom
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      // Back Button
                      SizedBox(
                        width: 100.w,
                        height: 49.h,
                        child: OutlinedButton(
                          onPressed: () {
                            if (currentStep > 1) {
                              pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              Get.back();
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppPallete.white,
                            side: const BorderSide(color: Color(0xFFE7E8E7)),
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(333.r),
                            ),
                          ),
                          child: Text(
                            'Back',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                              height: 1.0,
                              letterSpacing: 0,
                              color: const Color(0xFF1A0E14),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),

                      // Continue / Submit Button
                      Expanded(
                        child: SizedBox(
                          height: 49.h,
                          child: ElevatedButton(
                            onPressed: () {
                              if (currentStep < 4) {
                                pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                Get.offAllNamed(RoutesName.auth);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppPallete.primary,
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(333.r),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Continue',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.sp,
                                    height: 1.0,
                                    letterSpacing: 0,
                                    color: AppPallete.white,
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16.sp,
                                  color: AppPallete.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 60.h),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
