import 'package:budget_app/constants/enums.dart';
import 'package:budget_app/util/transactions.dart';

class Transaction {
  String title, id;
  double amount;
  TransactionType type;
  TransactionCategory category;
  String createdAt;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json['_id'],
        title: json['title'],
        amount: json['amount'],
        type: getType(json['t_type']),
        category: getCategory(json['t_category']),
        createdAt: json['createdAt'],
      );
}
