import 'package:budget_app/views/main_screen.dart';
import 'package:budget_app/views/signup_screen.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';
import '../styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = '/';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  String email = '', password = '';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: brandColor,
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Colors.white),
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 5,
              vertical: SizeConfig.blockSizeVertical * 2),
          margin: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 10,
              vertical: SizeConfig.blockSizeVertical * 2),
          child: Form(
              key: _key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // const Spacer(),
                  Text('Login',
                      style: TextStyle(
                          color: brandColor,
                          fontSize: SizeConfig.blockSizeVertical * 4)),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  TextFormField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: brandColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      labelStyle:
                          TextStyle(color: Colors.black.withOpacity(0.65)),
                      labelText: 'Email',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      email = value!.trim();
                    },
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  TextFormField(
                    cursorColor: Colors.black,
                    obscureText: true,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      labelStyle:
                          TextStyle(color: Colors.black.withOpacity(0.65)),
                      labelText: 'Password',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      password = value!.trim();
                    },
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(MainScreen.id);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeVertical * 2),
                        )),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 4),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, SignupScreen.id);
                    },
                    icon: const Icon(Icons.arrow_circle_right_outlined),
                    label: Text('Signup',
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 2)),
                  ),
                  // const Spacer(),
                ],
              )),
        ),
      ),
    );
  }
}
