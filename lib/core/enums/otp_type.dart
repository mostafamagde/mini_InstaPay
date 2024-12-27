enum OtpType {
  ChangeEmailConfirmationOtp('CHANGE_EMAIL'),
  LoginOtp('PRE_LOGIN'),
  SignupOtp('SIGNUP'),
  ForgetPasswordOtp('FORGET_PASSWORD'),
  ForgetPinOtp('forgetPin');

  final String value;

  const OtpType(this.value);
}
