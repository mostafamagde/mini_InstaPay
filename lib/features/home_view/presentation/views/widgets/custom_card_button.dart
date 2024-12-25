import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAccountCardButton extends StatelessWidget {
  const CustomAccountCardButton({super.key, required this.text, required this.icon});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          icon,
          color: theme.secondaryHeaderColor,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 16.sp),
        )
      ],
    );
  }
}
