import 'package:budget_app/router.dart';
import 'package:budget_app/styles.dart';
import 'package:budget_app/views/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget App',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(primary: brandColor)),
      // home: const MainScreen(),
      initialRoute: LoginScreen.id,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
