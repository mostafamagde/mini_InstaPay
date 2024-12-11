import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/features/otp/data/repositories/otp_change_email_repo.dart';
import 'package:untitled2/features/otp/data/repositories/otp_fotget_password_repo.dart';
import 'package:untitled2/features/otp/data/repositories/otp_login_repo.dart';
import 'package:untitled2/features/otp/data/repositories/otp_repo.dart';
import 'package:untitled2/features/otp/data/repositories/otp_signup_repo.dart';

class OtpFactory {

  OtpRepository createOtpRepo(String type,context){
    if(type==Constants.ConfirmChangeEmailString){
      return OtpChangeEmailRepo(context: context);
    } else if (type == Constants.loginString) {
      return OtpLoginRepo(context: context);
    } else if (type == Constants.signupString) {
      return OtpSignUpRepo(context: context); 
    } else if (type == Constants.forgetPasswordString) {
      return OtpForgetPasswordRepo(context: context);
    } else {
      throw Exception("Invalid OTP type");
    }
    
  }
}

