import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/custom_button.dart';
import 'package:untitled2/core/widgets/custom_snackbar.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled2/features/auth/data/repository/auth_repo_impl.dart';
import 'package:untitled2/features/auth/presentation/manger/auth_cubit/auth_cubit.dart';
import 'package:untitled2/features/otp/presentation/views/otp_view.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  _ForgetPasswordViewState createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(AuthRepoImpl()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Forgot Password'),
          centerTitle: true,
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => OtpView(
                          userToken: state.otpModel.token,
                          function: Constants.forgetPasswordString,
                        )),
              );
            } else if (state is AuthFail) {
              snackBar(content: state.message, context: context);
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is AuthLoading,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Enter your email address to reset your password',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                    CustomTextField(label: "Email address", icon: Icons.email, inputType: TextInputType.emailAddress, controller: emailController, valid: Validation.validateEmailTextField),
                    SizedBox(height: 16),
                    CustomButton(
                        onTap: () {
                          final email = emailController.text;
                          if (formKey.currentState!.validate()) {
                            context.read<AuthCubit>().forgetPassword(email);
                          }
                        },
                        label: "Reset Password")
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
