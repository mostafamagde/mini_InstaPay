import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';

import '../../../../core/widgets/CustomTitleContainer.dart';
import '../../../../core/widgets/custom_small_button.dart';
import '../manager/log_out_cubit/log_out_cubit.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
print(UserModel.getInstance().defaultAcc);
    var cubit = LogOutCubit.get(context);
    return BlocListener<LogOutCubit, LogOutState>(
      listener: (context, state) {
        if (state is LogOutSuccess) {
          print(state.successMessage);
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesNames.loginView,
            (route) => false,
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTitleContainer(
            title: "Setting",
),
   
          Expanded(
            child: GridView(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: [
                CustomSmallButton(
                  name: "Profile Management",
                  icon: Icons.settings,
                  padding: 25,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesNames.changeCridintials,
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
                    );
                  },
                ),
                CustomSmallButton(
                  padding: 25,
                  name: "Log Out",
                  icon: Icons.logout,
                  onTap: () => cubit.logOut(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
