import 'package:budget_app/views/add_transaction_screen.dart';
import 'package:budget_app/views/change_password_screen.dart';
import 'package:budget_app/views/edit_budget_screen.dart';
import 'package:budget_app/views/login_screen.dart';
import 'package:budget_app/views/main_screen.dart';
import 'package:budget_app/views/signup_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainScreen.id:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case AddTransactionScreen.id:
        return MaterialPageRoute(builder: (_) => const AddTransactionScreen());
      case EditBudgetScreen.id:
        return MaterialPageRoute(builder: (_) => const EditBudgetScreen());
      case ChangePasswordScreen.id:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
      case LoginScreen.id:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case SignupScreen.id:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route for ${settings.name}'),
                  ),
                ));
    }
  }
}