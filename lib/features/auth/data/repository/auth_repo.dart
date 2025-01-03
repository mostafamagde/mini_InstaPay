import 'package:mini_instapay/features/auth/data/models/otp_model.dart';
import 'package:mini_instapay/features/auth/data/models/signup_model.dart';

abstract class AuthRepository {
  Future<OtpModel> forgetPassword(String email);
  Future<OtpModel> signUp(SignUpModel signUpModel);
  Future<OtpModel> login(String email, String password);
  Future<void> enterPassword(String token, String password);
}
