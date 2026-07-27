import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class WalletBalanceCard extends StatelessWidget {
  final double balance;
  final String currencySymbol;

  const WalletBalanceCard({
    super.key,
    required this.balance,
    this.currencySymbol = '£',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppPallete.primaryText,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            'Available Balance',
            style: AppTextStyle.s14w4i(
              color: AppPallete.white
            ).copyWith(
              fontWeight: FontWeight.w500
            )
          ),
          const SizedBox(height: 8),
          Text(
            '$currencySymbol${balance.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: AppPallete.white,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }
}