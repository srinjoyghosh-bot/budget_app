import 'package:flutter/material.dart';

import '../size_config.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);
  static const String id = '/change-password';

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String oldPass = '', newPass = '', confirmNewPass = '';
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (WidgetsBinding.instance.window.viewInsets.bottom > 0.0) {
          // Keyboard is visible.
          FocusScope.of(context).requestFocus(FocusNode());
          return false;
        } else {
          // Keyboard is not visible.
          return true;
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('Change Password'),
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 5,
                      vertical: SizeConfig.blockSizeVertical * 2)
                  .copyWith(bottom: 0),
              child: Form(
                  key: _key,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // const Spacer(),
                        TextFormField(
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelStyle: TextStyle(
                                color: Colors.black.withOpacity(0.65)),
                            labelText: 'Current Password',
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a valid password';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            oldPass = value!.trim();
                          },
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical * 2),
                        TextFormField(
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelStyle: TextStyle(
                                color: Colors.black.withOpacity(0.65)),
                            labelText: 'New Password',
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a valid password';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            newPass = value!.trim();
                          },
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical * 2),
                        TextFormField(
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelStyle: TextStyle(
                                color: Colors.black.withOpacity(0.65)),
                            labelText: 'Confirm new Password',
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a valid password';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            confirmNewPass = value!.trim();
                          },
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical * 2),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.blockSizeVertical * 2.3),
                          ),
                        ),
                        // const Spacer(),
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
