import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/Constants.dart';

class AppThemeManager {
  static ThemeData mainTheme = ThemeData(
    scaffoldBackgroundColor: Constants.backgroundColor,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Constants.secondaryOrangeColor,
      foregroundColor: Constants.secondaryOrangeColor,
    ),
    primaryColor: Constants.primaryMouveColor,
    secondaryHeaderColor: Constants.secondaryOrangeColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Constants.primaryMouveColor,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 28.sp,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 18.sp,
      ),
      bodySmall: TextStyle(
        color: Colors.grey,
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
