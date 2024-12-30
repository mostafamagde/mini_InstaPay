enum OtpType {
  changeEmailConfirmationOtp('CHANGE_EMAIL'),
  loginOtp('PRE_LOGIN'),
  signupOtp('SIGNUP'),
  forgetPasswordOtp('FORGET_PASSWORD'),
  forgetPinOtp('forgetPin');

  final String value;

  const OtpType(this.value);
}
