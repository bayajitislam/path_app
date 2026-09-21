import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/features/onboarding/controllers/onboarding_controller.dart';
import 'package:path_app/features/onboarding/view/widgets/country_selector_field.dart';

class Step4Content extends StatelessWidget {
  final OnboardingController controller;

  const Step4Content({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Your Country',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 28.sp,
              color: const Color(0xFF1A0E14),
              height: 1.2,
              letterSpacing: -0.5.sp,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Choose your country to personalize your experience',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: const Color(0xFF636363),
              height: 1.4,
              letterSpacing: 0,
            ),
          ),
          SizedBox(height: 28.h),

          // Country Selector Pill
          Obx(
            () => CountrySelectorField(
              selectedCountry: controller.selectedCountry.value,
              onCountrySelected: (country) {
                controller.setCountry(country.name);
              },
            ),
          ),
        ],
      ),
    );
  }
}
