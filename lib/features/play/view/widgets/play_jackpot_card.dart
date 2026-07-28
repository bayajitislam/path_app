import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';

class PlayJackpotCard extends StatelessWidget {
  final double monthlyJackpot;
  final double weeklyJackpot;
  final double currentJackpot;
  final String currencySymbol;

  const PlayJackpotCard({
    super.key,
    required this.monthlyJackpot,
    required this.weeklyJackpot,
    required this.currentJackpot,
    this.currencySymbol = '£',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppPallete.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _JackpotItem(
            amount: monthlyJackpot,
            label: 'Monthly Jackpot',
            currencySymbol: currencySymbol,
          ),
          _JackpotItem(
            amount: weeklyJackpot,
            label: 'Weekly Jackpot',
            currencySymbol: currencySymbol,
          ),
          _JackpotItem(
            amount: currentJackpot,
            label: 'Current Jackpot',
            currencySymbol: currencySymbol,
          ),
        ],
      ),
    );
  }
}

class _JackpotItem extends StatelessWidget {
  final double amount;
  final String label;
  final String currencySymbol;

  const _JackpotItem({
    required this.amount,
    required this.label,
    required this.currencySymbol,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$currencySymbol${amount.toStringAsFixed(0)}',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppPallete.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppPallete.secondaryText,
          ),
        ),
      ],
    );
  }
}