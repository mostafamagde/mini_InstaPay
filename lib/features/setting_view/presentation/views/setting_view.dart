import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/widgets/CustomTitleContainer.dart';
import 'package:untitled2/core/widgets/custom_small_button.dart';
import 'package:untitled2/features/setting_view/presentation/manager/log_out_cubit/log_out_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              context, RoutesNames.loginView, (route) => false);
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
                itemCount: 6,
                itemBuilder: (context, index) {
                  final buttons = [
                    {
                      "name": "Profile Management",
                      "icon": Icons.settings,
                      "onTap": () {
                        Navigator.pushNamed(
                          context,
                          RoutesNames.changeCridintials,
                        );
                      }
                    },
                    {
                      "name": "Privacy Setting",
                      "icon": Icons.privacy_tip,
                      "onTap": () {
                        Navigator.pushNamed(
                          context,
                          RoutesNames.privacySetting,
                        );
                      }
                    },
                    {
                      "name": "Transactions",
                      "icon": Icons.receipt_long,
                      "onTap": () {
                        Navigator.pushNamed(
                          context,
                          RoutesNames.transactionsSummary,
                        );
                      }
                    },
                    {
                      "name": "Usage Analysis",
                      "icon": Icons.bar_chart,
                      "onTap": () {
                        Navigator.pushNamed(
                          context,
                          RoutesNames.accountUsageAnalysis,
                        );
                      }
                    },
                    {
                      "name": "Log Out",
                      "icon": Icons.logout,
                      "onTap": () => cubit.logOut(),
                    },
                    {
                      "name": "Change Default",
                      "icon": Icons.change_circle,
                      "onTap": () {
                        Navigator.pushNamed(
                          context,
                          RoutesNames.changeDefaultAccount,
                        );
                      }
                    },
                  ];

                  final button = buttons[index];
                  return CustomSmallButton(
                    name: button["name"] as String,
                    icon: button["icon"] as IconData,
                    onTap: button["onTap"] as VoidCallback,
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
