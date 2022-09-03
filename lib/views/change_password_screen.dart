import 'package:budget_app/constants/enums.dart';
import 'package:budget_app/util/snackbars.dart';
import 'package:budget_app/view_models/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  late AuthViewModel _model;

  void submit() async {
    final isValid = _key.currentState?.validate();
    if (isValid == null || !isValid) {
      return;
    }
    _key.currentState!.save();
    final result = await _model.updatePassword(
      oldPass,
      newPass,
      confirmNewPass,
    );
    if (result) {
      Navigator.of(context).pop();
      showSuccessSnackbar('Password updated!', context);
    } else {
      showErrorSnackbar(_model.errorMessage, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    _model = Provider.of<AuthViewModel>(context);
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
                          onPressed: () {
                            if (_model.state == ViewState.idle) {
                              submit();
                            }
                          },
                          child: _model.state == ViewState.idle
                              ? Text(
                                  'SAVE',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 2.3),
                                )
                              : SizedBox(
                                  height: SizeConfig.blockSizeVertical * 2.3,
                                  child: const CircularProgressIndicator(
                                      color: Colors.white)),
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
