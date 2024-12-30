import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mini_instapay/core/api_helper/api_constants.dart';
import 'package:mini_instapay/core/api_helper/api_manger.dart';
import 'package:mini_instapay/core/models/user_model.dart';
import 'package:mini_instapay/core/routes_manager/routes_names.dart';
import 'package:mini_instapay/features/otp/data/repositories/otp_repo.dart';

class OtpForgetPinRepo extends OtpRepository {
  final ApiManager _apiManager;

  const OtpForgetPinRepo(super.context, this._apiManager);

  @override
  Future<void> submitOtp({required String token, required String otp}) async {
    try {
      final response = await _apiManager.post(
        ApiConstants.confirmForgetPinOtp,
        headers: {"token": UserModel.instance.token},
        {
          "token": token,
          "OTP": otp,
        },
      );

      if (context.mounted) {
        Navigator.pushReplacementNamed(context, RoutesNames.forgotPin, arguments: response.data["token"]);
      }
    } catch (e) {
      if (e is DioException) {
        throw Exception(e.response?.data["message"] ?? e.message);
      }
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> resendOtp({required String token}) async {
    // try {
    //   final response = await _apiManager.post(
    //     ApiConstants.resendOtpEndPoint,
    //     {"token": token, "type": Constants.forgetPasswordString},
    //   );
    //   if (response.statusCode != 201) {
    //     throw Exception(response.data["message"]);
    //   }
    // } catch (e) {
    //   if (e is DioException) {
    //     throw Exception(e.response?.data["message"] ?? e.message);
    //   }
    //   throw Exception(e.toString());
    // }
  }
}
