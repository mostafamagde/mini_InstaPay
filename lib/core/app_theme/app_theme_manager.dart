import 'package:flutter/material.dart';
import 'package:untitled2/core/utils/Constants.dart';

class AppThemeManager {
  static ThemeData mainTheme = ThemeData(
    primaryColor: Constants.primaryMouveColor,
    secondaryHeaderColor: Constants.secondaryOrangeColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Constants.primaryMouveColor,
      ),
    ),
    textTheme:
      TextTheme(
        titleLarge: TextStyle(
          fontSize: 35,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        )
      )
  );
}
