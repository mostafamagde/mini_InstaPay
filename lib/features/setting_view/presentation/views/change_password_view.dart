import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../core/utils/validation.dart';
import '../../../../core/widgets/CustomTitleContainer.dart';
import '../../../../core/widgets/custom_button.dart';

import '../../../../core/widgets/custom_snackbar.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../manager/change_password_cubit/change_password_cubit.dart';

// ignore: must_be_immutable
class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {


    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          snackBar(content: state.message, context: context);
          Navigator.pop(context);
        } else if (state is ChangePasswordFailure) {
          snackBar(content: state.errMessage, context: context);
        }
      },
      builder: (context, state) {
        var cubit = ChangePasswordCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Column(
              children: [
                CustomTitleContainer(
                  title: "Change Password",
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  controller: oldPasswordController,
                  label: "Enter old Password",
                  icon: Icons.password,
                  inputType: TextInputType.visiblePassword,
                  valid: Validation.validatePasswordTextField,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextField(
                  controller: newPasswordController,
                  label: "Enter old Password",
                  icon: Icons.password,
                  inputType: TextInputType.visiblePassword,
                  valid: Validation.validatePasswordTextField,
                ),
                SizedBox(
                  height: 10,
                ),
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
