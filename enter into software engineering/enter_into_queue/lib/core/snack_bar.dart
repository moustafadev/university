import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  static badSnackBar(BuildContext context,String action) {
    CherryToast.error(
            borderRadius: 12,
            displayCloseButton: false,
            title: Text("Ошибка"),
            action: Text(action),
            animationType: AnimationType.fromRight,
            animationDuration: const Duration(milliseconds: 1000),
            autoDismiss: true)
        .show(context);
  }

  static goodSnackBar(BuildContext context) {
    CherryToast.success(
            borderRadius: 12,
            displayCloseButton: false,
            title: Text("Успешно"),
            animationType: AnimationType.fromRight,
            animationDuration: const Duration(milliseconds: 1000),
            autoDismiss: true)
        .show(context);
  }
}
