import 'package:mini_instapay/core/utils/Constants.dart';
import 'package:mini_instapay/features/otp/data/repositories/otp_change_email_repo.dart';
import 'package:mini_instapay/features/otp/data/repositories/otp_forget_pin.dart';
import 'package:mini_instapay/features/otp/data/repositories/otp_fotget_password_repo.dart';
import 'package:mini_instapay/features/otp/data/repositories/otp_login_repo.dart';
import 'package:mini_instapay/features/otp/data/repositories/otp_repo.dart';
import 'package:mini_instapay/features/otp/data/repositories/otp_signup_repo.dart';

class OtpFactory {
  OtpRepository createOtpRepo(String type, context) {
    if (type == Constants.ConfirmChangeEmailString) {
      return OtpChangeEmailRepo(context: context);
    } else if (type == Constants.loginString) {
      return OtpLoginRepo(context: context);
    } else if (type == Constants.signupString) {
      return OtpSignUpRepo(context: context);
    } else if (type == Constants.forgetPasswordString) {
      return OtpForgetPasswordRepo(context: context);
    } else if (type == Constants.forgetPin) {
      return OtpForgetPinRepo(context: context);
    }
    else {
      throw Exception("Invalid OTP type");
    }
  }
}
