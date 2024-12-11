import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAlertDialoge {
 static Future dialog(
      BuildContext context, TextStyle style, String title, String message) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK", style: style))
        ],
      ),
    );
  }
}
