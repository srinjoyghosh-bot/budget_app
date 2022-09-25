import 'package:budget_app/util/toasts.dart';
import 'package:budget_app/view_models/main_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/enums.dart';
import '../size_config.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);
  static const String id = '/edit-profile';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _key = GlobalKey<FormState>();
  String username = '', email = '';
  late MainViewModel _model;

  submit() async {
    FocusScope.of(context).requestFocus(FocusNode());
    final isValid = _key.currentState?.validate();
    if (isValid == null || !isValid) {
      return;
    }
    _key.currentState?.save();
    final result = await _model.editProfile(username, email);
    if (result) {
      Navigator.of(context).pop();
      showSuccessToast('Profile Updated', context);
    } else {
      showErrorToast(_model.errorMessage, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    _model = Provider.of<MainViewModel>(context);
    return Scaffold(
      // backgroundColor: brandColor,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(
              flex: 1,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 12,
              child: Image.asset('assets/icons/user.png'),
            ),
            Form(
                key: _key,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // const Spacer(),
                    TextFormField(
                      initialValue: _model.user?.name,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        labelStyle:
                            TextStyle(color: Colors.black.withOpacity(0.65)),
                        labelText: 'Username',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a valid username';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        username = value!.trim();
                      },
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 2),
                    TextFormField(
                      initialValue: _model.user?.email,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
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
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        email = value!.trim();
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
                                  fontSize: SizeConfig.blockSizeVertical * 2.3),
                            )
                          : SizedBox(
                              height: SizeConfig.blockSizeVertical * 2.3,
                              child: const CircularProgressIndicator(
                                  color: Colors.white)),
                    ),
                  ],
                )),
            const Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
