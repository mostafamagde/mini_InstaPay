import 'package:flutter/material.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomSmallButton extends StatelessWidget {
  CustomSmallButton({
    super.key,
    required this.name,
    required this.icon,
    this.onTap,
    this.padding = 0,
    this.verticalPadding=0
  });

  final String name;
  final IconData icon;
  final void Function()? onTap;
  final double padding;
  final double verticalPadding;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    // var media = MediaQuery.of(context).size;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: padding,vertical: verticalPadding),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(17),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.only(left: 4,right:4,bottom: 16),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                height: 65.r,
                width: 65.r,
                decoration: BoxDecoration(color: Constants.buttonBackgroundColor, borderRadius: BorderRadius.circular(22)),
                child: Icon(
                  icon,
                  color: theme.secondaryHeaderColor,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        name,
                        maxLines: 1,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.black,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
