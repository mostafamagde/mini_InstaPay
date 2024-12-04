import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/CustomTitleContainer.dart';
import 'package:untitled2/core/widgets/custom_button.dart';
import 'package:untitled2/core/widgets/custom_small_button.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';

class PrivacySettingView extends StatelessWidget {
  const PrivacySettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CustomTitleContainer(title: "Privacy Setting"),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: GridView(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: [
                CustomSmallButton(
                  padding: 25,
                  name: "Change Email",
                  icon: Icons.email,
                  onTap: () => Navigator.pushNamed(
                    context,
                    RoutesNames.changeEmail,
                  ),
                ),
                CustomSmallButton(
                  padding: 25,
                  name: "Change Password",
                  icon: Icons.password,
                  onTap: () => Navigator.pushNamed(
                    context,
                    RoutesNames.changePassword,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
