import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled2/core/api_helper/api_constants.dart';
import 'package:untitled2/core/api_helper/api_manger.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/custom_button.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';
import 'package:untitled2/features/auth/presentation/views/otp_view.dart';
import 'package:untitled2/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:untitled2/features/auth/presentation/views/widgets/custom_text_button.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                controller: _emailController,
                valid: Validation.validateEmailTextField,
              ),
              CustomTextField(
                label: "Password",
                icon: Icons.lock_outline_rounded,
                inputType: TextInputType.visiblePassword,
                controller: _passwordController,
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
                  if (formKey.currentState!.validate()){
                     final apiManager = ApiManager();
                    final body = {
                    "email": _emailController.text,
                    "password": _passwordController.text
};
                    apiManager.post(ApiConstants.preLogin, body).then((response) {
                      print("$response sssssssssssssssssssssssssssssssssssssssss ${response.statusCode}");
                      if (response.statusCode == 201) {
                          final Map<String, dynamic> responseBody = response.data;
                    final String userToken = responseBody['token'];
                    print(userToken);
                       Navigator.push(context, MaterialPageRoute(builder: (context) => OtpView(userToken: userToken,login: true,)));
                        print("Signup successful");
                      } else {
                        print("Failed to signup");
                      }
                    }).catchError((error) {
                      if (error is DioException) {
                        if (error.response != null) {
                          print("Error during signin: ${error.response?.data}");
                        } else {
                          print("Error during signin: ${error.message}");
                        }
                      } else {
                        print(error);
                      }
                    });

                  }
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

