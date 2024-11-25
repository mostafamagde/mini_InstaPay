import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CusttomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;

  const CusttomButton({
    super.key,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
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
