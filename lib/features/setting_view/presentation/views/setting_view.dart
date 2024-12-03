import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';

import '../../../../core/widgets/CustomTitleContainer.dart';
import '../../../../core/widgets/custom_small_button.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key, required this.token});

  final String token;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTitleContainer(title: "Setting",),
        Expanded(
          child: GridView(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: [
              CustomSmallButton(
                name: "Profile Management",
                icon: Icons.settings,
                padding:25 ,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RoutesNames.changeCridintials,
                    arguments: token,

                  );
                },
              ),
              CustomSmallButton(
                padding: 25,
                name: "Privacy Setting",
                icon: Icons.privacy_tip,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RoutesNames.privacySetting,
                    arguments: token,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
