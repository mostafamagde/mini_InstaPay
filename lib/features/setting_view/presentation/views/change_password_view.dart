import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/CustomTitleContainer.dart';
import 'package:untitled2/core/widgets/custom_button.dart';
import 'package:untitled2/core/widgets/custom_snackbar.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';
import 'package:untitled2/features/setting_view/presentation/manager/change_password_cubit/change_password_cubit.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          snackBar(content: state.message, context: context, color: Colors.green);
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
