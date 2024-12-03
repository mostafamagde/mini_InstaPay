import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/custom_button.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';
import 'package:untitled2/features/auth/presentation/views/otp_view.dart';

class EnterPasswordView extends StatelessWidget {
  
   EnterPasswordView({super.key, required this.token});
   final String token;
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
      var formKey = GlobalKey<FormState>();
    return  Scaffold(
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
              style: TextStyle(
                fontSize: 23.sp,
                fontWeight: FontWeight.w600
              ),
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
          CusttomButton(
            onTap: () {
              if(formKey.currentState!.validate()){
                  Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => OtpView(userToken: token,function: Constants.forgetPasswordString,password: passwordController.text,)),
              );
              }
            },
            label: "Submit"
          )
        ],
      ),
    ),
    );
  }
}