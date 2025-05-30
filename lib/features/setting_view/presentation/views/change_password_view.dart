import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_instapay/core/routes_manager/routes_names.dart';
import 'package:mini_instapay/core/utils/validation.dart';
import 'package:mini_instapay/core/widgets/custom_button.dart';
import 'package:mini_instapay/core/widgets/custom_snackbar.dart';
import 'package:mini_instapay/core/widgets/custom_text_field.dart';
import 'package:mini_instapay/features/setting_view/presentation/manager/change_password_cubit/change_password_cubit.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController reNewPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          snackBar(content: state.message, context: context, color: Colors.green);
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesNames.loginView,
            (route) => false,
          );
        } else if (state is ChangePasswordFailure) {
          snackBar(content: state.errMessage, context: context);
        }
      },
      builder: (context, state) {
        final ChangePasswordCubit cubit = ChangePasswordCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Change Password", style: TextStyle(color: Colors.white)),
          ),
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Expanded(child: SizedBox(height: 5)),
                      CustomTextField(
                        controller: oldPasswordController,
                        label: "Enter old Password",
                        icon: Icons.password,
                        inputType: TextInputType.visiblePassword,
                        valid: Validation.validatePasswordTextField,
                        obsecure: true,
                        pass: true,
                      ),
                      CustomTextField(
                        controller: newPasswordController,
                        label: "Enter new Password",
                        icon: Icons.password,
                        inputType: TextInputType.visiblePassword,
                        valid: (value) {
                          Validation.validatePasswordTextField(value);
                          if (reNewPasswordController.text.compareTo(newPasswordController.text) != 0) {
                            return "Your password doesn't match";
                          }
                          if (oldPasswordController.text.compareTo(newPasswordController.text) == 0) {
                            return "Your password should not be same as old password";
                          }
                          return null;
                        },
                        obsecure: true,
                        pass: true,
                      ),
                      CustomTextField(
                        controller: reNewPasswordController,
                        label: "Renter new Password",
                        icon: Icons.password,
                        inputType: TextInputType.visiblePassword,
                        valid: (value) {
                          Validation.validatePasswordTextField(value);
                          if (reNewPasswordController.text.compareTo(newPasswordController.text) != 0) {
                            return "Your password doesn't match";
                          }
                          if (oldPasswordController.text.compareTo(newPasswordController.text) == 0) {
                            return "Your password should not be same as old password";
                          }
                          return null;
                        },
                        obsecure: true,
                        pass: true,
                      ),
                      Expanded(child: SizedBox(height: 5)),
                      CustomButton(
                        label: "Submit",
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            cubit.changePassword(
                              newPass: newPasswordController.text,
                              oldPass: oldPasswordController.text,
                            );
                          }
                        },
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
