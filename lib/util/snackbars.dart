import 'package:flutter/material.dart';

void showErrorSnackbar(String error, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(error),
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.black,
  ));
}

void showSuccessSnackbar(String msg, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg),
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.black,
  ));
}
