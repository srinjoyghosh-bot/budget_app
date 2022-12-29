import 'package:budget_app/router.dart';
import 'package:budget_app/styles.dart';
import 'package:budget_app/view_models/auth_viewmodel.dart';
import 'package:budget_app/view_models/main_viewmodel.dart';
import 'package:budget_app/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // final LocalStorageService _service = locator<LocalStorageService>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthViewModel()),
        ChangeNotifierProvider(create: (ctx) => MainViewModel()),
      ],
      child: MaterialApp(
        title: 'Budget App',
        theme: ThemeData(
            colorScheme:
                ColorScheme.fromSwatch().copyWith(primary: brandColor)),
        // home: const MainScreen(),
        // initialRoute: _service.isLoggedIn ? MainScreen.id : LoginScreen.id,
        initialRoute: SplashScreen.id,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
