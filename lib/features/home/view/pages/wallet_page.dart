import 'package:flutter/material.dart';
import 'package:path_app/core/common/app_dialog.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_app_bar.dart';
import 'package:path_app/features/home/view/widgets/section_header.dart';
import 'package:path_app/features/home/view/widgets/wager_collection_banner.dart';
import 'package:path_app/features/home/view/widgets/wallet_balance_card.dart';

// Enum to keep track of transaction types
enum TransactionType { deposit, withdraw }

// Model class for transactions
class TransactionItem {
  final String title;
  final String date;
  final double amount;
  final TransactionType type;
  final String status;

  TransactionItem({
    required this.title,
    required this.date,
    required this.amount,
    required this.type,
    required this.status,
  });
}

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  // Selected tab state: default to deposit
  TransactionType _selectedType = TransactionType.deposit;

  // Sample mock data for transactions
  final List<TransactionItem> _allTransactions = [
    TransactionItem(
      title: 'Jackpot Payout',
      date: 'May 24',
      amount: 50.00,
      type: TransactionType.deposit,
      status: 'completed',
    ),
    TransactionItem(
      title: 'Bank Deposit',
      date: 'May 20',
      amount: 20.00,
      type: TransactionType.deposit,
      status: 'completed',
    ),
    TransactionItem(
      title: 'Weekly Withdrawal',
      date: 'May 18',
      amount: 15.00,
      type: TransactionType.withdraw,
      status: 'received',
    ),
    TransactionItem(
      title: 'ATM Withdrawal',
      date: 'May 12',
      amount: 30.00,
      type: TransactionType.withdraw,
      status: 'received',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Filter transactions based on active toggle tab
    final filteredTransactions = _allTransactions
        .where((item) => item.type == _selectedType)
        .toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PrimaryAppBar(
        title: 'Wallet',
        subtitle: 'Manage your funds and wagers',
      ),
      body: AppBg(
        child: SafeArea(
          child: Column(
            children: [
              // Scrollable Main Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Column(
                    children: [
                      const WalletBalanceCard(balance: 124.50),
                      const SizedBox(height: 16),
                      const WagerCollectionBanner(),
                      const SizedBox(height: 16),
                      const SectionHeader(title: 'Recent Transactions'),
                      const SizedBox(height: 16),

                      // Interactive Filter Toggle Switch
                      _buildTransactionFilter(),
                      const SizedBox(height: 16),

                      // Filtered Transactions List
                      if (filteredTransactions.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Text(
                            'No transactions found.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      else
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredTransactions.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            return _buildTransactionCard(
                              filteredTransactions[index],
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),

              // Fixed Bottom Action Buttons
              _buildBottomActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  /// Segmented control widget for filtering Deposit / Withdraw
  Widget _buildTransactionFilter() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Deposit Tab
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedType = TransactionType.deposit;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _selectedType == TransactionType.deposit
                      ? Colors.grey.shade100
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Deposit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _selectedType == TransactionType.deposit
                        ? Colors.black
                        : Colors.grey.shade500,
                  ),
                ),
              ),
            ),
          ),

          // Withdraw Tab
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedType = TransactionType.withdraw;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _selectedType == TransactionType.withdraw
                      ? Colors.grey.shade100
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Withdraw',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _selectedType == TransactionType.withdraw
                        ? Colors.black
                        : Colors.grey.shade500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Transaction Card with dynamic color coding and status badge
  Widget _buildTransactionCard(TransactionItem item) {
    final isDeposit = item.type == TransactionType.deposit;

    // Green for Deposit (+), Red for Withdraw (-)
    final amountColor = isDeposit ? const Color(0xFF00A86B) : Colors.red;
    final iconBgColor = isDeposit
        ? const Color(0xFFE8F8F0)
        : const Color(0xFFFFEBEB);
    final iconColor = isDeposit ? const Color(0xFF00A86B) : Colors.red;
    final iconData = isDeposit
        ? Icons.south_west_rounded
        : Icons.north_east_rounded;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Icon Container
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),

          // Title & Date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 13,
                      color: Colors.grey.shade500,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item.date,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Amount & Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isDeposit ? '+' : '-'}£${item.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: amountColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    size: 13,
                    color: amountColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    item.status,
                    style: TextStyle(
                      color: amountColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Fixed Bottom Deposit/Withdraw buttons
  Widget _buildBottomActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const AppDialog(
                    title: 'Success',
                    message: '200£ Deposited Successfully',
                    type: DialogType.info,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2ECC71),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              icon: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_downward_rounded,
                  color: Color(0xFF2ECC71),
                  size: 18,
                ),
              ),
              label: const Text(
                'Deposit',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const AppDialog(
                    title: 'Success',
                    message: '200£ Withdrawn Successfully',
                    type: DialogType.info,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2ECC71),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              icon: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_upward_rounded,
                  color: Color(0xFF2ECC71),
                  size: 18,
                ),
              ),
              label: const Text(
                'Withdraw',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
