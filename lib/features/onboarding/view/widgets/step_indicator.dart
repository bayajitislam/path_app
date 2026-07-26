import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_app/core/theme/app_pallete.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepIndicator({
    super.key,
    required this.currentStep,
    this.totalSteps = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final isActive = index < currentStep;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index < totalSteps - 1 ? 8.w : 0),
            child: Container(
              height: 4.h,
              decoration: BoxDecoration(
                color: isActive ? AppPallete.primary : const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
        );
      }),
    );
  }
}
