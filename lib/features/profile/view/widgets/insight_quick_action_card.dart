import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class QuickActionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String subtitle;

  const QuickActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.iconColor = const Color(0xFF4CAF50),
    this.iconBgColor = const Color(0xFFE8F5E9),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            style: AppTextStyle.s12w4i(color: AppPallete.primaryText),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: AppTextStyle.s16w4i(
              color: AppPallete.primaryText,
            ).copyWith(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

// 2x2 grid wrapper for the 4 quick actions
class InsightQuickActionGrid extends StatelessWidget {
  const InsightQuickActionGrid({super.key});

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
          icon: Icons.trending_up,
          iconColor: Color(0xFF2563EB),
          iconBgColor: Color(0xFFEFF6FF),
          title: 'Score Trend',
          subtitle: '+5%',
        ),
        QuickActionCard(
          icon: Icons.token_sharp,
          iconColor: Color(0xFF059669),
          iconBgColor: Color(0xFFECFDF5),
          title: 'Current Rank',
          subtitle: 'Top 15%',
        ),
      ],
    );
  }
}
