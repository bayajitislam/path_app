import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_button.dart';
import 'package:path_app/features/subscription/constants/subscription_images.dart';
import 'package:path_app/features/subscription/view/widgets/subscription_header.dart';
import 'package:path_app/features/subscription/view/widgets/subscription_plan_card.dart';
import 'package:path_app/routes/routes_name.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  int _selectedIndex = 0;

  final List<SubscriptionPlan> _plans = const [
    SubscriptionPlan(
      icon: SubscriptionImages.quarterly,
      title: 'Quarterly',
      subtitle: 'Perfect for short-term users',
      price: r'$4.99',
    ),
    SubscriptionPlan(
      icon: SubscriptionImages.annually,
      title: 'Annually',
      subtitle: 'Save more with 12-month access',
      price: r'$13.99',
    ),
    SubscriptionPlan(
      icon: SubscriptionImages.lifetime,
      title: 'Lifetime',
      subtitle: 'Lifetime access with premium benefits',
      price: r'$49.99',
      saveBadge: 'Save \$9.99',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isFromProfile = Get.arguments != null && Get.arguments['isFromProfile'] == true;

    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Get.toNamed(RoutesName.basePage),
          ),
        ],
      ),
      body: AppBg(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SubscriptionHeader(),
                SizedBox(height: 32.h),
                ...List.generate(_plans.length, (index) {
                  return SubscriptionPlanCard(
                    plan: _plans[index],
                    isSelected: _selectedIndex == index,
                    onTap: () => setState(() => _selectedIndex = index),
                  );
                }),
                const Spacer(),
                PrimaryButton(
                  buttonName: isFromProfile ? 'Upgrade Now' : 'Subscribe Now',
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
