import 'package:flutter/material.dart';
import 'package:untitled2/core/utils/Constants.dart';

class AppThemeManager {
  static ThemeData mainTheme = ThemeData(
    scaffoldBackgroundColor: Constants.backgroundColor,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.black
      ),

      backgroundColor: Constants.secondaryOrangeColor,
      foregroundColor:  Constants.secondaryOrangeColor,
    ),
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
        ),
        bodyMedium: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 18,

        ),
        bodySmall: TextStyle(
          color: Colors.grey,
          fontSize: 15,
          fontWeight: FontWeight.w400,

        ),

      ),

  );
}
