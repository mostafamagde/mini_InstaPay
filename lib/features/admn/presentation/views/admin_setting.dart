import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes_manager/routes_names.dart';
import '../../../../core/widgets/CustomTitleContainer.dart';
import '../../../../core/widgets/custom_small_button.dart';
import '../../../setting_view/presentation/manager/log_out_cubit/log_out_cubit.dart';

class AdminSetting extends StatelessWidget {
  const AdminSetting({super.key});

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