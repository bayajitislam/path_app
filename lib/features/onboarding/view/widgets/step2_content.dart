import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/features/onboarding/controllers/onboarding_controller.dart';
import 'package:path_app/features/onboarding/view/widgets/option_field.dart';

class Step2Content extends StatelessWidget {
  final OnboardingController controller;

  const Step2Content({super.key, required this.controller});

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
                    child: OptionField(
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
