import 'package:budget_app/views/add_transaction_screen.dart';
import 'package:budget_app/views/change_password_screen.dart';
import 'package:budget_app/views/edit_budget_screen.dart';
import 'package:budget_app/views/edit_profile_screen.dart';
import 'package:budget_app/views/login_screen.dart';
import 'package:budget_app/views/main_screen.dart';
import 'package:budget_app/views/signup_screen.dart';
import 'package:budget_app/views/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.id:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case MainScreen.id:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case AddTransactionScreen.id:
        return MaterialPageRoute(builder: (_) => const AddTransactionScreen());
      case EditBudgetScreen.id:
        return MaterialPageRoute(builder: (_) => const EditBudgetScreen());
      case EditProfileScreen.id:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case ChangePasswordScreen.id:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
      case LoginScreen.id:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case SignupScreen.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const SignupScreen(),
          transitionDuration: const Duration(seconds: 1),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );
      // return MaterialPageRoute(builder: (_) => const SignupScreen());
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
