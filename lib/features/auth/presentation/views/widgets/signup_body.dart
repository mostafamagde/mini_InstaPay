import 'dart:convert';

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

class SignupBody extends StatefulWidget {
  const SignupBody({super.key});

  @override
  State<SignupBody> createState() => _SignupBodyState();
}

class _SignupBodyState extends State<SignupBody> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

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
                    controller: firstNameController,
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    label: "Last Name",
                    icon: Icons.person_outline_rounded,
                    inputType: TextInputType.name,
                    valid: Validation.validateRegularTextField,
                    controller: lastNameController,
                  ),
                ),
              ],
            ),
              CustomTextField(
                  label: "Phone Number",
                  icon: Icons.phone,
                  inputType: TextInputType.phone,
                  valid: Validation.validateNumberTextField,
                  controller: phoneNumberController,
                ),
            CustomTextField(
              label: "email",
              icon: Icons.email,
              inputType: TextInputType.emailAddress,
              valid: Validation.validateEmailTextField,
              controller: emailController,
            ),
            CustomTextField(
              label: "Password",
              icon: Icons.lock_outline_rounded,
              inputType: TextInputType.emailAddress,
              valid: Validation.validatePasswordTextField,
              controller: passwordController,
            ),
            SizedBox(
              height: 8,
            ),
            CusttomButton(
              onTap: () {
                if (formKey.currentState!.validate())
                {
                 final apiManager = ApiManager();
                    final body = {
                      "firstName": firstNameController.text,
                      "lastName": lastNameController.text,
                      "email": emailController.text,
                      "password": passwordController.text,
                      "mobileNumber": phoneNumberController.text
};
                    apiManager.post(ApiConstants.signupEndPoint, body).then((response) {
                      print("$response sssssssssssssssssssssssssssssssssssssssss ${response.statusCode}");
                      if (response.statusCode == 201) {
                          final Map<String, dynamic> responseBody = response.data;
                    final String userToken = responseBody['userToken'];
                    print(userToken);
                       Navigator.push(context, MaterialPageRoute(builder: (context) => OtpView(userToken: userToken),));
                        print("Signup successful");
                      } else {
                        // Handle failed signup
                        print("Failed to signup");
                      }
                    }).catchError((error) {
                      if (error is DioException) {
                        // Check if the error has a response and print the message
                        if (error.response != null) {
                          print("Error during signup: ${error.response?.data}");
                        } else {
                          print("Error during signup: ${error.message}");
                        }
                      } else {
                        print(error);
                      }
                    });
                }
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
                    Navigator.pushReplacementNamed(context, RoutesNames.loginView);
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
