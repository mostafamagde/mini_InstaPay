import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:untitled2/core/models/user_model.dart';

import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/CustomTitleContainer.dart';

import 'package:untitled2/core/widgets/custom_text_field.dart';

import '../../../../core/utils/Constants.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../../otp/presentation/views/otp_view.dart';
import '../manager/change_email_cubit/change_email_cubit.dart';

// ignore: must_be_immutable
class ChangeEmailView extends StatelessWidget {
  ChangeEmailView({super.key});

  TextEditingController emailController = TextEditingController(text: UserModel.getInstance().email);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    return BlocConsumer<ChangeEmailCubit, ChangeEmailState>(
      listener: (context, state) {
        if (state is ChangeEmailSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpView(
                  userToken: state.message,
                  function: Constants.ConfirmChangeEmailString),
            ),
          );
        } else if (state is ChangeEmailFailure) {
          snackBar(content: state.errMessage, context: context);
        }
      },
      builder: (context, state) {
        var cubit = ChangeEmailCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Column(
              children: [
                CustomTitleContainer(title: "Enter New Email"),
                SizedBox(height: 10.h),
                CustomTextField(
                  controller: emailController,
                  label: "Enter new Email",
                  icon: Icons.email,
                  inputType: TextInputType.emailAddress,
                  valid: Validation.validateEmailTextField,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CusttomButton(
                  label: "Submit",
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      cubit.changeEmail(email: emailController.text);
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
