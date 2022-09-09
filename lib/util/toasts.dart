import 'package:budget_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

void showErrorToast(String error, BuildContext context) {
  MotionToast.error(
    title: const Text("Error"),
    description: Text(error),
    toastDuration: const Duration(seconds: 3),
    width: SizeConfig.blockSizeHorizontal * 70,
    height: SizeConfig.blockSizeVertical * 10,
  ).show(context);
}

void showWarningToast(String warning, BuildContext context) {
  MotionToast.warning(
    title: const Text("Warning!"),
    description: Text(warning),
    toastDuration: const Duration(seconds: 3),
    width: SizeConfig.blockSizeHorizontal * 70,
    height: SizeConfig.blockSizeVertical * 10,
  ).show(context);
}

void showSuccessToast(String msg, BuildContext context) {
  MotionToast.success(
    description: Text(msg),
    toastDuration: const Duration(seconds: 3),
    width: SizeConfig.blockSizeHorizontal * 70,
    height: SizeConfig.blockSizeVertical * 10,
  ).show(context);
}
