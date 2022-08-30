import 'package:budget_app/models/transaction.dart';

class User {
  String id, name, email, password;
  String? avatar;
  List<Transaction>? transactions;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.avatar,
    this.transactions,
  });
}
