import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mini_instapay/core/api_helper/api_constants.dart';
import 'package:mini_instapay/core/api_helper/api_manger.dart';
import 'package:mini_instapay/core/enums/otp_type.dart';
import 'package:mini_instapay/core/models/user_model.dart';
import 'package:mini_instapay/core/routes_manager/routes_names.dart';
import 'package:mini_instapay/features/otp/data/repositories/otp_repo.dart';

class OtpChangeEmailRepo extends OtpRepository {
  const OtpChangeEmailRepo(super.context, this._apiManager);

  final ApiManager _apiManager;

  @override
  Future<void> submitOtp({required String token, required String otp}) async {
    try {
      final response = await _apiManager.patch(
        ApiConstants.ConfirmChangeEmail,
        data: {
          "token": token,
          "otp": int.parse(otp),
        },
        headers: {"token": UserModel.instance.token},
      );
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
      final response = await _apiManager.post(
        ApiConstants.resendOtpEndPoint,
        {"token": token, "type": OtpType.ChangeEmailConfirmationOtp.value},
        headers: {"token": UserModel.instance.token},
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
