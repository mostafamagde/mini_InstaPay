import 'package:flutter/cupertino.dart';

abstract class OtpRepository {
  final BuildContext context;

  const OtpRepository(this.context);

  Future<void> submitOtp({
    required String token,
    required String otp,
  });

  Future<void> resendOtp({
    required String token,
  });
}
