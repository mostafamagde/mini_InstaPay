import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/custom_button.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';
import 'package:untitled2/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:untitled2/features/auth/presentation/views/widgets/custom_text_button.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AuthHeader(),
              SizedBox(
                height: 30.h,
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
              CustomTextButton(
                label: "Forget Password",
                onTap: () {},
              ),
              SizedBox(
                height: 8,
              ),
              CusttomButton(
                onTap: () {
                  if (formKey.currentState!.validate())
                    Navigator.pushReplacementNamed(
                        context, RoutesNames.layoutView);
                },
                label: "Login",
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CustomTextButton(
                    label: "Sign Up",
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, RoutesNames.signupView);
                    },
                  ),
                ],
              )
            
            ],
          ),
        ),
      ),
    );
  }
}

