import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled2/core/utils/Constants.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final double? padding;
  final Color color;
  CustomButton({super.key, required this.onTap, required this.label, this.padding, this.color=Constants.primaryMouveColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding ?? 35),
            child: ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: color,
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
