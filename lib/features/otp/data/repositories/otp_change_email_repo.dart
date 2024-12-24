import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled2/core/api_helper/api_constants.dart';
import 'package:untitled2/core/api_helper/api_manger.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/core/utils/service_locator.dart';
import 'package:untitled2/features/otp/data/repositories/otp_repo.dart';

class OtpChangeEmailRepo extends OtpRepository {
  final ApiManager _apiManager;

  OtpChangeEmailRepo({required super.context}) : _apiManager = ServiceLocator.getIt.get<ApiManager>();

  @override
  Future<void> submitOtp({required String token, required String otp}) async {
    try {
      final response = await _apiManager.patch(ApiConstants.ConfirmChangeEmail, data: {
        "token": token,
        "otp": int.parse(otp),
      }, headers: {
        "token": UserModel.instance.token
      });
      if (response.statusCode != 201 && response.statusCode != 200) {
        throw Exception(response.data["message"]);
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesNames.layoutView,
          (route) => false,
        );
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
      final response = await _apiManager.post(ApiConstants.resendOtpEndPoint, {"token": token, "type": Constants.ConfirmChangeEmailString}, headers: {"token": UserModel.instance.token});
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
