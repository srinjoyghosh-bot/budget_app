import 'package:budget_app/models/transaction.dart';

class User {
  String id, name, email, password, budget;
  String? avatar;
  List<Transaction>? transactions;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.budget,
    this.avatar,
    this.transactions,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['_id'],
        name: json['username'],
        email: json['email'],
        password: json['password'],
        budget: json['budget'],
      );
}
