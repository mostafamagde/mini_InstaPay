import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled2/core/api_helper/api_manger.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/CustomTitleContainer.dart';
import 'package:untitled2/core/widgets/custom_snackbar.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';
import 'package:untitled2/features/auth/presentation/views/otp_view.dart';

import '../../../../core/api_helper/api_constants.dart';
import '../../../../core/widgets/custom_button.dart';

class ChangeEmailView extends StatelessWidget {
  ChangeEmailView({super.key});

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    UserModel user = UserModel.getInstance();
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
              onTap: ()async {
                if (formKey.currentState!.validate()) {

                  print(user.token);
                  ApiManager service = ApiManager();
                 await service.patch(ApiConstants.changeEmail,headers: {
                   "token": user.token,

                 },data: {
                   "email": emailController.text,
                 }).then(
                    (value) {
                      if (value.statusCode == 201||value.statusCode ==200) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpView(
                                userToken: user.token!,
                                function: Constants.changeEmailString),
                          ),
                        );
                      } else {
                        snackBar(content: "Invalid email", context: context);
                      }
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
