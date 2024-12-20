import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled2/core/api_helper/api_constants.dart';
import 'package:untitled2/core/api_helper/api_manger.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/core/utils/service_locator.dart';
import 'package:untitled2/features/otp/data/repositories/otp_repo.dart';

class OtpForgetPasswordRepo extends OtpRepository {
  final ApiManager _apiManager;

  OtpForgetPasswordRepo({required super.context}) : _apiManager = ServiceLocator.getIt.get<ApiManager>();

  @override
  Future<void> submitOtp({required String token, required String otp}) async {
    try {
      final response = await _apiManager.post(
        ApiConstants.ConfirmOtpForgetEdnPoint,
        {
          "token": token,
          "otp": int.parse(otp),
        },
      );
      if (response.statusCode != 201) {
        throw Exception(response.data["message"]);
      } else {
        Navigator.pushReplacementNamed(context, RoutesNames.EnterPasswordView, arguments: response.data["token"]);
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
    try {
      final response = await _apiManager.post(
        ApiConstants.resendOtpEndPoint,
        {"token": token, "type": Constants.forgetPasswordString},
      );
      if (response.statusCode != 201) {
        throw Exception(response.data["message"]);
      }
    } catch (e) {
      if (e is DioException) {
        throw Exception(e.response?.data["message"] ?? e.message);
      }
      throw Exception(e.toString());
    }
  }
}
