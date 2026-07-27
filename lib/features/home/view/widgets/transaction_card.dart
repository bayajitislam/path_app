import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

enum TransactionType { debit, credit }

class TransactionCard extends StatelessWidget {
  final String title;
  final String date;
  final double amount;
  final String currencySymbol;
  final TransactionType type;
  final String status;

  const TransactionCard({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    this.currencySymbol = '£',
    required this.type,
    this.status = 'completed',
  });

  @override
  Widget build(BuildContext context) {
    final isCredit = type == TransactionType.credit;
    final amountColor = isCredit ? Color(0xFF059669) : AppPallete.primaryText;
    final amountPrefix = isCredit ? '+' : '-';
    final iconBgColor = isCredit
        ? const Color(0xFFECFDF5)
        : const Color(0xFFF9FAFB);
    final iconColor = isCredit
        ? const Color(0xFF059669)
        : const Color(0xFF4B5563);
    final iconData = isCredit
        ? Icons.arrow_downward_rounded
        : Icons.arrow_upward_rounded;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppPallete.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Center(child: Icon(iconData, size: 18, color: iconColor)),
          ),
          const SizedBox(width: 12),
          // Title + date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.s14w4i(
                    color: AppPallete.primaryText,
                  ).copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: AppPallete.secondaryText,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      date,
                      style: AppTextStyle.s10w4i(
                        color: AppPallete.secondaryText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Amount + status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$amountPrefix$currencySymbol${amount.toStringAsFixed(2)}',
                style: AppTextStyle.s14w4i(
                  color: amountColor,
                ).copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 3),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    size: 12,
                    color: AppPallete.primary,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    status,
                    style: AppTextStyle.s10w4i(color: AppPallete.secondaryText),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
