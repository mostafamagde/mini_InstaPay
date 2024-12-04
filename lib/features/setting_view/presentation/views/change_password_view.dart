import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/api_helper/api_constants.dart';
import '../../../../core/api_helper/api_manger.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/utils/Constants.dart';
import '../../../../core/utils/validation.dart';
import '../../../../core/widgets/CustomTitleContainer.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../auth/presentation/views/otp_view.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTitleContainer(
              title: "Change Password",
            ),
            SizedBox(height: 10.h),
            CustomTextField(
              controller: oldPasswordController,
              label: "Enter old Password",
              icon: Icons.email,
              inputType: TextInputType.visiblePassword,
              valid: Validation.validatePasswordTextField,
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomTextField(
              controller: newPasswordController,
              label: "Enter old Password",
              icon: Icons.email,
              inputType: TextInputType.visiblePassword,
              valid: Validation.validatePasswordTextField,
            ),
            SizedBox(
              height: 10,
            ),
            CusttomButton(
              label: "Submit",
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  try {
                    ApiManager service = ApiManager();
                    final response = await service.patch(
                      ApiConstants.updatePassword,
                      headers: {
                        "token": UserModel.getInstance().token,
                      },
                      data: {
                        "newPassword": newPasswordController.text,
                        "oldPassword": oldPasswordController.text,
                      },
                    );
                    if (response.statusCode == 201 ||
                        response.statusCode == 200) {
                      snackBar(content: "Password Updated successfully", context: context);

                    } else {
                      snackBar(content: response.statusMessage, context: context);
                    }
                  } catch (e) {
                    if (e is DioException) {
                      if (e.response != null) {
                        print(e.response);
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${e.message}')),
                      );
                    }
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
