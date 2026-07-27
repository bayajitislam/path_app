import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';
import 'package:path_app/routes/routes_name.dart';

class QuickActionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const QuickActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.iconColor = const Color(0xFF4CAF50),
    this.iconBgColor = const Color(0xFFE8F5E9),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppPallete.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon badge
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Icon(icon, size: 16, color: iconColor)),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: AppTextStyle.s14w4i(
                color: AppPallete.primaryText,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: AppTextStyle.s12w4i(color: AppPallete.secondaryText),
            ),
          ],
        ),
      ),
    );
  }
}

// 2x2 grid wrapper for the 4 quick actions
class HomeQuickActionGrid extends StatelessWidget {
  const HomeQuickActionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        QuickActionCard(
          onTap: () => Get.toNamed(RoutesName.wallet),
          icon: Icons.account_balance_wallet_outlined,
          iconColor: Color(0xFF5C6BC0),
          iconBgColor: Color(0xFFE8EAF6),
          title: 'Wallet',
          subtitle: '£124.50',
        ),
        QuickActionCard(
          icon: Icons.swap_horiz_rounded,
          iconColor: Color(0xFFEF6C00),
          iconBgColor: Color(0xFFFFF3E0),
          title: 'Trips',
          subtitle: '12 this week',
        ),
        QuickActionCard(
          onTap: () => Get.toNamed(RoutesName.insight),
          icon: Icons.trending_up_rounded,
          iconColor: Color(0xFF4CAF50),
          iconBgColor: Color(0xFFE8F5E9),
          title: 'Insights',
          subtitle: 'Tips & Stats',
        ),
        QuickActionCard(
          icon: Icons.help_outline_rounded,
          iconColor: Color(0xFF6B7280),
          iconBgColor: Color(0xFFF3F4F6),
          title: 'Support & Feedback',
          subtitle: 'Help & FAQ',
        ),
      ],
    );
  }
}
