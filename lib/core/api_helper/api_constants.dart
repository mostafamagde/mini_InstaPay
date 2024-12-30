class ApiConstants {
  // static const String baseUrl = 'http://192.168.1.32:3000/';
  static const String baseUrl = 'http://10.0.2.2:3000/';
  static const String signupEndPoint = 'auth/signup/';
  static const String preLogin = "auth/preLogin";
  static const String loginEndPoint = 'auth/login/';
  static const String vetifyEmailEndPoint = 'auth/verifyEmail/';
  static const String changeCredintialsEndPoint = 'user';
  static const String changeEmail = 'user/changeEmail';
  static const String confirmChangeEmail = 'user/confirmChangeEmail';
  static const String updatePassword = 'user/updatePassword';
  static const String getAllBanks = 'bank/';
  static const String getUserData = "user/";
  static const String addGetBankAccount = "account/";
  static const String logOut = "user/logout";
  static const String deleteAccount = "/account/";
  static const String getBalance = "account/balance/";
  static const String resendOtpEndPoint = 'auth/resendOTP/';
  static const String getTransactionEndPoint = "/transaction/history";
  static const String getAllNotifications = '/notification';
  static const String readNotifications = '/notification/markAsRead/';
  static const String sendMoney = "/transaction/send-money";
  static const String receiveMoney = "transaction/request-recieve-money";
  static const String forgetPasswordEdnPoint = 'auth/forget-password';
  static const String confirmOtpForgetEdnPoint = 'auth/confirm-otp-forget';
  static const String sendforgetPasswordMailEndPoint = 'auth/send-forget-password-mail/';
  static const String changeDefaultAccount = 'transaction/change-default';
  static const String getAllTransactionEndPoint = "/transaction/admin";
  static const String confirmReceive = "transaction/confirm-recieve/";
  static const String rejectReceive = "transaction/reject-recieve/";
  static const String markAsSuspicious = "/transaction/admin/suspiciousTransaction";
  static const String allUsersAdmin = "user/admin";
  static const String banUsersAdmin = "user/admin/banned";
  static const String requestRefund = "/transaction/request-refund";
  static const String acceptRefund = '/transaction/admin/approve-refund';
  static const String rejectRefund = '/transaction/admin/reject-refund';
  static const String updatePin = 'account/PIN/';
  static const String changeLimit = '/account/limit/';
  static const String forgetPin = '/account/sendForgetPINOTP/';
  static const String confirmForgetPinOtp = 'account/confirmOTPforgetPIN';
  static const String updateForgetPinOtp = 'account/forgetPIN';
}
