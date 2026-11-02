enum TransactionType { deposit, withdraw }

enum TransactionStatus { completed, pending, received }

class TransactionModel {
  final String id;
  final String title;
  final String date;
  final double amount;
  final TransactionType type;
  final TransactionStatus status;

  const TransactionModel({
    required this.id,
    required this.title,
    required this.date,
    required this.amount,
    required this.type,
    required this.status,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      date: json['date'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      type: json['type'] == 'withdraw'
          ? TransactionType.withdraw
          : TransactionType.deposit,
      status: TransactionStatus.values.firstWhere(
        (s) => s.name == json['status'],
        orElse: () => TransactionStatus.completed,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'amount': amount,
      'type': type.name,
      'status': status.name,
    };
  }

  TransactionModel copyWith({
    String? id,
    String? title,
    String? date,
    double? amount,
    TransactionType? type,
    TransactionStatus? status,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }
}

