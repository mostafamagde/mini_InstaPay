import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_instapay/core/enums/otp_type.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mini_instapay/core/models/user_model.dart';
import 'package:mini_instapay/core/routes_manager/routes_names.dart';
import 'package:mini_instapay/core/widgets/custom_title_container.dart';
import 'package:mini_instapay/core/widgets/custom_small_button.dart';
import 'package:mini_instapay/core/widgets/custom_snackbar.dart';
import 'package:mini_instapay/features/otp/presentation/views/otp_view.dart';
import 'package:mini_instapay/features/setting_view/data/models/button_model.dart';
import 'package:mini_instapay/features/setting_view/presentation/manager/forget_pin_cubit/forget_pin_cubit.dart';
import 'package:mini_instapay/features/setting_view/presentation/manager/log_out_cubit/log_out_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class SettingView extends StatelessWidget {
  SettingView({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final LogOutCubit cubit = LogOutCubit.get(context);

    final List<ButtonModel> buttonModels = [
      ButtonModel(name: "Profile Management", icon: Icons.settings, onTap: () => Navigator.pushNamed(context, RoutesNames.changeCridintials)),
      ButtonModel(name: "Privacy Setting", icon: Icons.privacy_tip, onTap: () => Navigator.pushNamed(context, RoutesNames.privacySetting)),
      ButtonModel(
        name: "Change limit",
        icon: Icons.money,
        onTap: () {
          Navigator.pushNamed(context, RoutesNames.changeLimit, arguments: UserModel.instance.defaultAcc?.id);
        },
      ),
      ButtonModel(
        name: "Forget PIN",
        icon: Icons.security,
        onTap: () {
          if (UserModel.instance.defaultAcc != null) {
            BlocProvider.of<ForgetPinCubit>(context).forgetPin(UserModel.instance.defaultAcc!.id!);
          } else {
            snackBar(content: "You don't have account yet", context: context);
          }
        },
      ),
      ButtonModel(
        name: "Log Out",
        icon: Icons.logout,
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                "Are you sure you want to delete this account",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    cubit.logOut();
                  },
                  child: Text(
                    "Confirm",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      ButtonModel(
        name: "Analytics",
        icon: Icons.analytics_sharp,
        onTap: () {
          Navigator.pushNamed(context, RoutesNames.analyticsView);
        },
      ),
    ];

    return BlocConsumer<ForgetPinCubit, ForgetPinState>(
      listener: (context, state) {
        if (state is ForgetPinSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpView(userToken: state.userToken, type: OtpType.forgetPinOtp),
            ),
          );
        }
        if (state is ForgetPinFailure) {
          snackBar(content: state.errMessage, context: context);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is ForgetPinLoading,
          child: BlocListener<LogOutCubit, LogOutState>(
            listener: (context, state) {
              if (state is LogOutSuccess) {
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
          ),
        );
      },
    );
  }
}
