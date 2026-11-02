import 'package:path_app/features/home/models/transaction_model.dart';

abstract class WalletRepository {
  Future<double> getBalance();
  Future<List<TransactionModel>> getTransactions();
}

class LocalWalletRepository implements WalletRepository {
  const LocalWalletRepository();

  @override
  Future<double> getBalance() async {
    return 124.50;
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    return const [
      TransactionModel(
        id: 'tx_1',
        title: 'Jackpot Payout',
        date: 'May 24',
        amount: 50.00,
        type: TransactionType.deposit,
        status: TransactionStatus.completed,
      ),
      TransactionModel(
        id: 'tx_2',
        title: 'Bank Deposit',
        date: 'May 20',
        amount: 20.00,
        type: TransactionType.deposit,
        status: TransactionStatus.completed,
      ),
      TransactionModel(
        id: 'tx_3',
        title: 'Weekly Withdrawal',
        date: 'May 18',
        amount: 15.00,
        type: TransactionType.withdraw,
        status: TransactionStatus.received,
      ),
      TransactionModel(
        id: 'tx_4',
        title: 'ATM Withdrawal',
        date: 'May 12',
        amount: 30.00,
        type: TransactionType.withdraw,
        status: TransactionStatus.received,
      ),
    ];
  }
}

