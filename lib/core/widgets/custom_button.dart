import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  double? padding;

   CustomButton({
    super.key,
    required this.onTap,
    required this.label,
    this.padding

  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Expanded(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal:padding?? 35),
            child: ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12)),
                child: Text(
                  label,
                  style: TextStyle(color: Colors.white, fontSize: 20.sp),
                )),
          ),
        ),
      ],
    );
  }
}
