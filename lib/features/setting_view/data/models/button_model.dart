import 'package:flutter/material.dart';

class ButtonModel {
  final String name;
  final IconData icon;
  final void Function() onTap;

  ButtonModel({required this.name, required this.icon, required this.onTap});
}
