import 'package:flutter/material.dart';

class StatisticsElementModel {
  final String label;
  final String value;
  final Color backgroundColor;
  final IconData? icon;
  final Color textColor;

  const StatisticsElementModel({
    required this.label,
    required this.value,
    required this.backgroundColor,
    this.icon,
    required this.textColor,
  });
}
