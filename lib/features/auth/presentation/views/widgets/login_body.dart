import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/custom_button.dart';
import 'package:untitled2/core/widgets/custom_snackbar.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';
import 'package:untitled2/features/auth/presentation/manger/auth_cubit/auth_cubit.dart';
import 'package:untitled2/features/otp/presentation/views/otp_view.dart';
import 'package:untitled2/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:untitled2/features/auth/presentation/views/widgets/custom_text_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => OtpView(
                        userToken: state.otpModel.token,
                        function: Constants.loginString,
                      )),
            );
          } else if (state is AuthFail) {
            snackBar(content: state.message, context: context);
          }
        },
        builder: (context, state) {
          bool isLoading = state is AuthLoading;

          return ModalProgressHUD(
            inAsyncCall: isLoading,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
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
                      onTap: () {
                        Navigator.pushNamed(context, RoutesNames.ForgetPasswordView);
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthCubit>().login(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
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
                            Navigator.pushNamed(context, RoutesNames.signupView);
                          },
                        ),
                      ],
                    ),



                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
