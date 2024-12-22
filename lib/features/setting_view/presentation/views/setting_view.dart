import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/widgets/CustomTitleContainer.dart';
import 'package:untitled2/core/widgets/custom_small_button.dart';
import 'package:untitled2/features/setting_view/presentation/manager/log_out_cubit/log_out_cubit.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
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
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
                  name: "Transactions",
                  icon: Icons.receipt_long,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesNames.transactionsSummary,
                    );
                  },
                ),
                CustomSmallButton(
                  padding: 25,
                  name: "Usage Analysis",
                  icon: Icons.bar_chart,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesNames.accountUsageAnalysis,
                    );
                  },
                ),
                CustomSmallButton(
                  padding: 25,
                  name: "Log Out",
                  icon: Icons.logout,
                  onTap: () => cubit.logOut(),
                ),
                CustomSmallButton(
                  padding: 25,
                  name: "Change Default",
                  icon: Icons.change_circle,
                  onTap: () => Navigator.pushNamed(
                    context,
                    RoutesNames.changeDefaultAccount,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
