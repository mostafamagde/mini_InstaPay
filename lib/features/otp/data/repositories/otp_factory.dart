import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mini_instapay/core/api_helper/api_manger.dart';
import 'package:mini_instapay/core/utils/Constants.dart';
import 'package:mini_instapay/core/utils/service_locator.dart';
import 'package:mini_instapay/features/otp/data/repositories/otp_change_email_repo.dart';
import 'package:mini_instapay/features/otp/data/repositories/otp_forget_pin.dart';
import 'package:mini_instapay/features/otp/data/repositories/otp_fotget_password_repo.dart';
import 'package:mini_instapay/features/otp/data/repositories/otp_login_repo.dart';
import 'package:mini_instapay/features/otp/data/repositories/otp_repo.dart';
import 'package:mini_instapay/features/otp/data/repositories/otp_signup_repo.dart';

class OtpFactory {
  const OtpFactory();

  OtpRepository createOtpRepo(String type, BuildContext context) {
    if (type == Constants.ConfirmChangeEmailString) {
      return OtpChangeEmailRepo(context, ServiceLocator.getIt<ApiManager>());
    } else if (type == Constants.loginString) {
      return OtpLoginRepo(context, ServiceLocator.getIt<ApiManager>(), ServiceLocator.getIt<FlutterSecureStorage>());
    } else if (type == Constants.signupString) {
      return OtpSignUpRepo(context, ServiceLocator.getIt<ApiManager>());
    } else if (type == Constants.forgetPasswordString) {
      return OtpForgetPasswordRepo(context, ServiceLocator.getIt<ApiManager>());
    } else if (type == Constants.forgetPin) {
      return OtpForgetPinRepo(context, ServiceLocator.getIt<ApiManager>());
    } else {
      throw Exception("Invalid OTP type");
    }
  }
}
