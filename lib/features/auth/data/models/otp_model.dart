class OtpModel {
  String token;
  String? otp;

  OtpModel({required this.token, this.otp});

  factory OtpModel.fromJson(Map<String, dynamic> json) {
    return OtpModel(
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'otp': otp,
    };
  }
}




