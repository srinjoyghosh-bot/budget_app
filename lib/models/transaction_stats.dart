import 'package:budget_app/models/transaction.dart';

class TransactionStats {
  double total, food, clothes, travel, miscellaneous;
  List<Transaction> transactions;

  TransactionStats({
    required this.total,
    required this.food,
    required this.clothes,
    required this.travel,
    required this.miscellaneous,
    required this.transactions,
  });

  factory TransactionStats.fromJson(Map<String, dynamic> json) =>
      TransactionStats(
          total: json['net_total_spent'].toDouble(),
          food: json['food_cost'].toDouble(),
          clothes: json['clothes_cost'].toDouble(),
          travel: json['travel_cost'].toDouble(),
          miscellaneous: json['miscellaneous_cost'].toDouble(),
          transactions: List<Transaction>.from(json['transactions']
              .map((transaction) => Transaction.fromJson(transaction))));
}
