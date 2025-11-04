import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ToastUtils {
  static void showSuccess(String message) {
    _showToast(message, backgroundColor: Colors.green);
  }

  static void showError(String message) {
    _showToast(message, backgroundColor: Colors.redAccent);
  }

  static void showWarning(String message) {
    _showToast(message, backgroundColor: Colors.orangeAccent);
  }

  static void showInfo(String message) {
    _showToast(message, backgroundColor: Colors.blueAccent);
  }

  static void _showToast(String message, {required Color backgroundColor}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
