import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.label,
    required this.icon,
    required this.inputType,
    this.valid,
    this.function,
    this.controller,
    this.node,
    this.centerText = false,
    this.obsecure = false,
  });

  final String label;
  final IconData icon;
  final TextInputType inputType;
  final FormFieldValidator<String>? valid;

  final void Function(String)? function;
  final TextEditingController? controller;
  FocusNode? node;
  bool centerText;
  bool obsecure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        textAlign: centerText ? TextAlign.center : TextAlign.start,
        focusNode: node,
        controller: controller,
        onChanged: function,
        validator: valid,
        keyboardType: inputType,
        obscureText: obsecure,
        maxLines: 1,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(icon, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
