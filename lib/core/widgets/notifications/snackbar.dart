import 'package:flutter/material.dart';

class SnackBarNotifyer {
  BuildContext context;

  SnackBarNotifyer(this.context);

  void showSnackBarMessage(String message, Color color) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        backgroundColor: color,
        content: Text(message),
      ));
  }
}
