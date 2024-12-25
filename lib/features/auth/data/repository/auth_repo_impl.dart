import 'package:dio/dio.dart';
import 'package:mini_instapay/core/api_helper/api_constants.dart';
import 'package:mini_instapay/core/api_helper/api_manger.dart';
import 'package:mini_instapay/features/auth/data/models/otp_model.dart';
import 'package:mini_instapay/features/auth/data/models/signup_model.dart';
import 'package:mini_instapay/features/auth/data/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepository {
  final apiManager = ApiManager();
  
  @override
  Future<OtpModel> forgetPassword(String email) {
    final body = {
      "email": email,
    };
    return apiManager.post(ApiConstants.SendforgetPasswordMailEdnPoint, body).then((response) {
      print("$response sssssssssssssssssssssssssssssssssssssssss ${response.statusCode}");

      final Map<String, dynamic> responseBody = response.data;
      final String userToken = responseBody['token'];
      print(userToken);
      print("Sent successful");
      return OtpModel.fromJson(responseBody);
    });
  }

  Future<void> enterPassword(String token, String password) async {
    final body = {"token": token, "password": password};
    await apiManager.post(ApiConstants.forgetPasswordEdnPoint, body);
  }

  @override
  Future<OtpModel> login(String email, String password) {
    final body = {"email": email, "password": password};
    return apiManager.post(ApiConstants.preLogin, body).then((response) {
      print("$response sssssssssssssssssssssssssssssssssssssssss ${response.statusCode}");
      if (response.statusCode == 201) {
        final Map<String, dynamic> responseBody = response.data;
        final String userToken = responseBody['token'];
        print(userToken);
        print("Login successful");
        return OtpModel.fromJson(responseBody);
      } else {
        throw Exception("Login failed with status: ${response.statusCode}");
      }
    }).catchError((error) {
      if (error is DioException) {
        if (error.response != null) {
          throw Exception("Error during signin: ${error.response!.data['message']}");
        } else {
          throw Exception("Error during signin: ${error.message}");
        }
      } else {
        throw Exception(error);
      }
    });
  }

  @override
  Future<OtpModel> signUp(SignUpModel signUpModel) async {
    final response = await apiManager.post(ApiConstants.signupEndPoint, signUpModel.toJson());
    return OtpModel.fromJson(response.data);
  }
}
