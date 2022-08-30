import 'package:budget_app/constants/enums.dart';

class Transaction {
  String title;
  double amount;
  TransactionType type;
  TransactionCategory category;

  Transaction({
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
  });
}
