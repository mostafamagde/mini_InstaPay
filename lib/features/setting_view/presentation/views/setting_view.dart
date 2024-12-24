import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/widgets/CustomTitleContainer.dart';
import 'package:untitled2/core/widgets/custom_small_button.dart';
import 'package:untitled2/features/setting_view/data/models/button_model.dart';
import 'package:untitled2/features/setting_view/presentation/manager/log_out_cubit/log_out_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final LogOutCubit cubit = LogOutCubit.get(context);
    final List<ButtonModel> buttonModels = [
      ButtonModel(name: "Profile Management", icon: Icons.settings, onTap: () => Navigator.pushNamed(context, RoutesNames.changeCridintials)),
      ButtonModel(name: "Privacy Setting", icon: Icons.privacy_tip, onTap: () => Navigator.pushNamed(context, RoutesNames.privacySetting)),
      ButtonModel(name: "Change Default", icon: Icons.change_circle, onTap: () => Navigator.pushNamed(context, RoutesNames.changeDefaultAccount)),
      ButtonModel(name:"Change limit",icon: Icons.money,onTap: (){
        Navigator.pushNamed(context, RoutesNames.changeLimit);
      }),
      ButtonModel(name: "Log Out", icon: Icons.logout, onTap: () => cubit.logOut()),
    ];

    return BlocListener<LogOutCubit, LogOutState>(
      listener: (context, state) {
        if (state is LogOutSuccess) {
          print(state.successMessage);
          Navigator.pushNamedAndRemoveUntil(context, RoutesNames.loginView, (route) => false);
        }
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CustomTitleContainer(
              title: "Setting",
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: buttonModels.length,
                itemBuilder: (context, index) {
                  return CustomSmallButton(
                    name: buttonModels[index].name,
                    icon: buttonModels[index].icon,
                    onTap: buttonModels[index].onTap,
                    padding: 16,
                    verticalPadding: 8.h,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
