import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/custom_button.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';
import 'package:untitled2/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:untitled2/features/auth/presentation/views/widgets/custom_text_button.dart';

class SignupBody extends StatelessWidget {
  const SignupBody({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            AuthHeader(),
            SizedBox(
              height: 30.h,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: "First Name",
                    icon: Icons.person_outline_rounded,
                    inputType: TextInputType.name,
                    valid: Validation.validateRegularTextField,
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    label: "Last Name",
                    icon: Icons.person_outline_rounded,
                    inputType: TextInputType.name,
                    valid: Validation.validateRegularTextField,
                  ),
                ),
              ],
            ),
              CustomTextField(
                  label: "Phone Number",
                  icon: Icons.phone,
                  inputType: TextInputType.phone,
                  valid: Validation.validateNumberTextField,
                ),
            CustomTextField(
              label: "email",
              icon: Icons.email,
              inputType: TextInputType.emailAddress,
              valid: Validation.validateEmailTextField,
            ),
            CustomTextField(
              label: "Password",
              icon: Icons.lock_outline_rounded,
              inputType: TextInputType.emailAddress,
              valid: Validation.validatePasswordTextField,
            ),
            SizedBox(
              height: 8,
            ),
            CusttomButton(
              onTap: () {
                if (formKey.currentState!.validate())
                  Navigator.pushReplacementNamed(context, RoutesNames.layoutView);
              },
              label: "Sign Up",
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already has an account?",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                CustomTextButton(
                  label: "Sign In",
                  onTap: () {
                    Navigator.pushReplacementNamed(context, RoutesNames.OtpView);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
