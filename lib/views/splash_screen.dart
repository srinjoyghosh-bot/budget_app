import 'package:budget_app/styles.dart';
import 'package:flutter/material.dart';

import '../locator.dart';
import '../services/local_storage_service.dart';
import '../size_config.dart';
import 'login_screen.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String id = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LocalStorageService _service = locator<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: brandColor,
      body: Center(
        child: Image.asset(
          'assets/logo/budgeting.png',
          height: SizeConfig.blockSizeVertical * 20,
          width: SizeConfig.blockSizeHorizontal * 50,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _goToNextScreen();
  }

  void _goToNextScreen() {
    Future.delayed(const Duration(seconds: 3), () async {
      String route = _service.isLoggedIn ? MainScreen.id : LoginScreen.id;
      Navigator.pushReplacementNamed(context, route);
    });
  }
}
