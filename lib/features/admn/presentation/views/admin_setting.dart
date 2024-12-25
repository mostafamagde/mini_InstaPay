import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/widgets/CustomTitleContainer.dart';
import 'package:untitled2/core/widgets/custom_small_button.dart';
import 'package:untitled2/features/setting_view/presentation/manager/log_out_cubit/log_out_cubit.dart';

class AdminSetting extends StatelessWidget {
  const AdminSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final LogOutCubit cubit = LogOutCubit.get(context);

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
                  icon: Icons.receipt_long,
                  name: "Transactions Summary",
                  padding: 15,
                  verticalPadding: 15,
                  onTap: () => Navigator.pushNamed(context, RoutesNames.transactionsSummary),
                ),
                CustomSmallButton(
                  icon: Icons.bar_chart,
                  name: "Usage Analysis",
                  padding: 15,
                  verticalPadding: 15,
                  onTap: () => Navigator.pushNamed(context, RoutesNames.accountUsageAnalysis),
                ),
                CustomSmallButton(
                  padding: 15,
                  name: "Log Out",
                  icon: Icons.logout,
                  verticalPadding: 15,
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
