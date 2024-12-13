class ApiConstants {
  static const String baseUrl = 'http://10.0.2.2:3000/';
  static const String signupEndPoint = 'auth/signup/';
  static const String preLogin = "auth/preLogin";
  static const String loginEndPoint = 'auth/login/';
  static const String vetifyEmailEndPoint = 'auth/verifyEmail/';
  static const String changeCredintialsEndPoint = 'user';
  static const String changeEmail = 'user/changeEmail';
  static const String ConfirmChangeEmail = 'user/confirmChangeEmail';
  static const String updatePassword = 'user/updatePassword';
  static const String getAllBanks = 'bank/';
  static const String getUserData="user/";
  static const String addGetBankAccount="account/";
  static const String logOut="user/logout";
  static const String deleteAccount="/account/";
  static const String getBalance="account/balance/";
  static const String resendOtpEndPoint= 'auth/resendOTP/';
  static const String getTransactionEndPoint="/transaction/history";
  static const String getAllNotifications='/notification';
  static const String readNotifications='/notification/markAsRead/';
  static const String sendMoney="/transaction/send-money";
  static const String forgetPasswordEdnPoint='auth/forget-password';
  static const String ConfirmOtpForgetEdnPoint='auth/confirm-otp-forget';
  static const String SendforgetPasswordMailEdnPoint='auth/send-forget-password-mail/';
  static const String confirmReceive="transaction/confirm-recieve/";
  static const String rejectReceive="transaction/reject-recieve/";
}
