import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/core/constants/app_images.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_button.dart';
import 'package:path_app/features/subscription/constants/subscription_images.dart';
import 'package:path_app/routes/routes_name.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionPage> {
  int _selectedIndex = 0;

  final List<_PlanData> _plans = const [
    _PlanData(
      icon: SubscriptionImages.quarterly,
      title: 'Quarterly',
      subtitle: 'Perfect for short-term users',
      price: r'$4.99',
    ),
    _PlanData(
      icon: SubscriptionImages.annually,
      title: 'Annually',
      subtitle: 'Save more with 12-month access',
      price: r'$13.99',
    ),
    _PlanData(
      icon: SubscriptionImages.lifetime,
      title: 'Lifetime',
      subtitle: 'Lifetime access with premium benefits',
      price: r'$49.99',
      saveBadge: 'Save \$9.99',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      resizeToAvoidBottomInset: true,
      body: AppBg(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60.h),
                Center(
                  child: Image.asset(
                    AppImages.appIcon,
                    width: 120.w,
                    height: 120.w,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Upgrade to access premium features',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzel(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                    height: 1.2,
                    letterSpacing: 0,
                    color: const Color(0xFF1A0E14),
                  ),
                ),
                SizedBox(height: 32.h),
                ...List.generate(_plans.length, (index) {
                  final plan = _plans[index];
                  final isSelected = _selectedIndex == index;
                  return Padding(
                    padding: EdgeInsets.only(
                      top: plan.saveBadge != null ? 10.h : 0,
                      bottom: 12.h,
                    ),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedIndex = index),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: double.infinity,
                            padding: EdgeInsets.all(16.r),
                            decoration: BoxDecoration(
                              color: AppPallete.white,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: isSelected
                                    ? AppPallete.primary
                                    : const Color(0xFFE7E8E7),
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  plan.icon,
                                  width: 44.w,
                                  height: 44.w,
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        plan.title,
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp,
                                          height: 1.0,
                                          letterSpacing: 0,
                                          color: const Color(0xFF1A0E14),
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        plan.subtitle,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp,
                                          height: 1.4,
                                          letterSpacing: 0,
                                          color: const Color(0xFF636363),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  plan.price,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.sp,
                                    height: 1.0,
                                    letterSpacing: 0,
                                    color: const Color(0xFF34C759),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (plan.saveBadge != null && isSelected)
                            Positioned(
                              top: -10.h,
                              right: 12.w,
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 200),
                                opacity: 1.0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppPallete.primary,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    plan.saveBadge!,
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11.sp,
                                      height: 1.0,
                                      letterSpacing: 0,
                                      color: AppPallete.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }),
                const Spacer(),
                PrimaryButton(
                  buttonName: 'Next',
                  onPressed: () {
                    Get.toNamed(RoutesName.basePage);
                  },
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlanData {
  final String icon;
  final String title;
  final String subtitle;
  final String price;
  final String? saveBadge;

  const _PlanData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.price,
    this.saveBadge,
  });
}
