import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mini_instapay/core/utils/constants.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 100.h,
          ),
          Text(
            "Welcome To ",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "Mini InstaPay ",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Constants.primaryMouveColor,
              fontSize: 27.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
