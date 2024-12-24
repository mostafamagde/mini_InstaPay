import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
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
    this.pass = false,
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

  bool pass;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        textAlign: widget.centerText ? TextAlign.center : TextAlign.start,
        focusNode: widget.node,
        controller: widget.controller,
        onChanged: widget.function,
        validator: widget.valid,
        keyboardType: widget.inputType,
        obscureText: widget.obsecure,
        maxLines: 1,
        decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(widget.icon, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            suffixIcon: widget.pass? IconButton(
              onPressed: () {
                widget.obsecure = !widget.obsecure;
                setState(() {});
              },
              icon: Icon(
                widget.obsecure ? Icons.visibility_off : Icons.visibility,
                size: widget.pass ? 25 : 0,
                color:widget.obsecure? Colors.grey:Colors.black,
              ),
            ):SizedBox()),
      ),
    );
  }
}
