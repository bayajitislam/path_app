import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_app_bar.dart';
import 'package:path_app/features/profile/view/widgets/earning_metric_card.dart';
import 'package:path_app/features/profile/view/widgets/jackpot_notice_banner.dart';

// Component Imports
// import 'package:path_app/features/earnings/widgets/earning_metric_card.dart';
// import 'package:path_app/features/earnings/widgets/jackpot_notice_banner.dart';

class EarningsPage extends StatelessWidget {
  const EarningsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PrimaryAppBar(
        title: 'Earnings',
        subtitle: 'See your earnings overview',
      ),
      body: AppBg(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),

                // ── 2x2 Metric Grid ──
                GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.5,
                  ),
                  children: const [
                    EarningMetricCard(
                      title: 'Total Net Earnings',
                      value: '+£0.00',
                      subtitle: 'across 0 competitions',
                    ),
                    EarningMetricCard(
                      title: 'Total Wagered',
                      value: '£0.00',
                      subtitle: '0 winning weeks',
                    ),
                    EarningMetricCard(
                      title: 'Total Payout',
                      value: '£0.00',
                      subtitle: 'prize pool + wager returns',
                    ),
                    EarningMetricCard(
                      title: 'Win Rate',
                      value: '-',
                      subtitle: '0 of 0 settled',
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // ── Competition History Section ──
                Text(
                  'Competition History',
                  style: AppTextStyle.s14w4i(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),

                const SizedBox(height: 55),

                // ── Empty State Indicator ──
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppPallete.white,
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.emoji_events_outlined,
                          size: 28,
                          color: AppPallete.secondaryText.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'No competitions entered yet',
                        style: AppTextStyle.s14w4i(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppPallete.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // ── Bottom Jackpot Info Banner ──
                const JackpotNoticeBanner(),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
