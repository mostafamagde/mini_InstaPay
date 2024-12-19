import 'package:flutter/material.dart';

snackBar({required content, required context, Color color = Colors.red}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        content,
      ),
      backgroundColor: color,
    ),
  );
}
