import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:untitled2/core/api_helper/api_constants.dart';
import 'package:untitled2/core/api_helper/api_manger.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/core/utils/service_locator.dart';
import 'otp_repo.dart';

class OtpLoginRepo extends OtpRepository {
  final ApiManager _apiManager;

  OtpLoginRepo({required super.context})
      : _apiManager = ServiceLocator.getIt.get<ApiManager>();

  @override
  Future<void> submitOtp({required String token, required String otp}) async {
    try {
      final response = await _apiManager.post(
        ApiConstants.loginEndPoint,
        {
          "token": token,
          "otp": int.parse(otp),
        },
      );
      if (response.statusCode != 201) {
        throw Exception(response.data["message"]);
      } else {
        UserModel user = UserModel.getInstance();
        user.token = response.data["token"];
        final storage = new FlutterSecureStorage();
        await storage.write(key: "token", value: user.token);
        final userDataResponse = await _apiManager
            .get(ApiConstants.getUserData, headers: {"token": user.token});
        ;
        if (userDataResponse.statusCode != 200 && userDataResponse.statusCode != 201) {
          throw Exception(response.data["message"]);
        } else {
          user.setFromjson(userDataResponse.data["data"]);
        }
        Navigator.pushReplacementNamed(
          context,
          RoutesNames.layoutView,
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
      final response = await _apiManager.post(
        ApiConstants.resendOtpEndPoint,
        {"token": token, "type": Constants.loginString},
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