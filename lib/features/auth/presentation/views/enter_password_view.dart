import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/custom_button.dart';
import 'package:untitled2/core/widgets/custom_snackbar.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';
import 'package:untitled2/features/auth/presentation/manger/auth_cubit/auth_cubit.dart';
import 'package:untitled2/features/otp/presentation/views/otp_view.dart';

class EnterPasswordView extends StatelessWidget {
  EnterPasswordView({super.key});
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final String token = ModalRoute.of(context)?.settings.arguments as String;
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is AuthSuccess){
          Navigator.pushNamed(context, RoutesNames.loginView);
        }
        else if(state is AuthFail){
          snackBar(content: state.message, context: context);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is AuthLoading,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Forgot Password'),
              centerTitle: true,
            ),
            body: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Enter your new password',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 23.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  CustomTextField(
                    label: "New Password",
                    icon: Icons.lock_outline_rounded,
                    inputType: TextInputType.visiblePassword,
                    controller: passwordController,
                    valid: Validation.validatePasswordTextField,
                  ),
                  SizedBox(height: 16),
                  CustomButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context).SubmitNewPassword(token,passwordController.text);
                        }
                      },
                      label: "Submit")
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
