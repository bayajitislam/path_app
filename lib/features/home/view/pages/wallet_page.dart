import 'package:flutter/material.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_app_bar.dart';
import 'package:path_app/features/home/view/widgets/section_header.dart';
import 'package:path_app/features/home/view/widgets/transaction_card.dart';
import 'package:path_app/features/home/view/widgets/wager_collection_banner.dart';
import 'package:path_app/features/home/view/widgets/wallet_balance_card.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PrimaryAppBar(
        title: 'Wallet',
        subtitle: 'Manage your funds and wagers',
      ),
      body: AppBg(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ).copyWith(bottom: 300),
            child: Column(
              children: [
                WalletBalanceCard(balance: 124.50),
                SizedBox(height: 16),

                WagerCollectionBanner(),
                SizedBox(height: 16),
                // Section header
                SectionHeader(title: 'Recent Transactions'),
                SizedBox(height: 16),
                TransactionCard(
                  title: 'Weekly Wager',
                  date: 'Yesterday',
                  amount: 10.00,
                  type: TransactionType.debit,
                ),
                SizedBox(height: 12),
                TransactionCard(
                  title: 'Jackpot Payout',
                  date: 'May 24',
                  amount: 50.00,
                  type: TransactionType.credit,
                ),
                SizedBox(height: 12),
                TransactionCard(
                  title: 'Deposit',
                  date: 'May 20',
                  amount: 20.00,
                  type: TransactionType.credit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
