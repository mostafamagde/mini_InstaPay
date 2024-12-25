import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mini_instapay/core/utils/Constants.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const CustomTextButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        child: Text(
          label,
          style: TextStyle(
            color: Constants.primaryMouveColor,
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
          ),
        ));
  }
}
