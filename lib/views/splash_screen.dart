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

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final LocalStorageService _service = locator<LocalStorageService>();
  late Animation<double> animation;
  late AnimationController controller;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: brandColor,
      body: Center(
        child: Image.asset(
          'assets/logo/budgeting.png',
          height: SizeConfig.blockSizeVertical * animation.value,
          width: SizeConfig.blockSizeHorizontal * animation.value,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = Tween<double>(begin: 20, end: 50).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
    _goToNextScreen();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _goToNextScreen() {
    Future.delayed(const Duration(seconds: 3), () async {
      String route = _service.isLoggedIn ? MainScreen.id : LoginScreen.id;
      Navigator.pushReplacementNamed(context, route);
    });
  }
}
