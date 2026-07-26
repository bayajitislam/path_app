import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/features/onboarding/controllers/onboarding_controller.dart';
import 'package:path_app/features/onboarding/view/widgets/step_indicator.dart';
import 'package:path_app/routes/routes_name.dart';

class OnboardingPage extends GetView<OnboardingController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // PageController to handle swipe/navigation between steps
    final PageController pageController = PageController();

    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      body: AppBg(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Obx(() {
              final currentStep = controller
                  .currentStep
                  .value; // Reactive step index (1, 2, or 3)

              return Column(
                children: [
                  // Header Section (Step Indicator & Counter)
                  SizedBox(height: 24.h),
                  StepIndicator(currentStep: currentStep, totalSteps: 3),
                  SizedBox(height: 14.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Step $currentStep of 3',
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                        color: const Color(0xFF636363),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Scrollable Page Content
                  Expanded(
                    child: PageView(
                      controller: pageController,
                      physics:
                          const NeverScrollableScrollPhysics(), // Controls navigation strictly via buttons
                      onPageChanged: (index) {
                        controller.currentStep.value = index + 1;
                      },
                      children: [
                        _Step1Content(),
                        _Step2Content(controller: controller),
                        _Step3Content(),
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
                              if (currentStep < 3) {
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

// -----------------------------------------------------------------------------
// STEP 1 CONTENT
// -----------------------------------------------------------------------------
class _Step1Content extends StatelessWidget {
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
              hintText: 'Your full name',
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

// -----------------------------------------------------------------------------
// STEP 2 CONTENT
// -----------------------------------------------------------------------------
class _Step2Content extends StatelessWidget {
  final OnboardingController controller;

  const _Step2Content({required this.controller});

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
          Obx(
            () => Column(
              children: List.generate(controller.options.length, (index) {
                final isSelected = controller.selectedIndex.value == index;
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: _OptionField(
                      title: controller.options[index]['title']!,
                      subtitle: controller.options[index]['subtitle']!,
                      isSelected: isSelected,
                      onTap: () => controller.select(index),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// STEP 3 CONTENT
// -----------------------------------------------------------------------------
class _Step3Content extends StatelessWidget {
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

// -----------------------------------------------------------------------------
// OPTION FIELD WIDGET
// -----------------------------------------------------------------------------
class _OptionField extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionField({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(maxWidth: 346.w),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppPallete.white,
          borderRadius: BorderRadius.circular(333.r),
          border: Border.all(
            color: isSelected ? AppPallete.primary : const Color(0xFFE7E8E7),
            width: isSelected ? 2.w : 1.w,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20.r,
              height: 20.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE7E8E7), width: 1.w),
                color: isSelected ? AppPallete.primary : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(Icons.check, size: 12.sp, color: AppPallete.white)
                  : null,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      height: 1.0,
                      letterSpacing: 0,
                      color: const Color(0xFF1A0E14),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      height: 1.0,
                      letterSpacing: 0,
                      color: const Color(0xFF636363),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
