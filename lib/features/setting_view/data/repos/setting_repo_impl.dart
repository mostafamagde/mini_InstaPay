import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mini_instapay/core/api_helper/api_constants.dart';
import 'package:mini_instapay/core/api_helper/api_manger.dart';
import 'package:mini_instapay/core/errors/errors.dart';
import 'package:mini_instapay/core/models/user_model.dart';
import 'package:mini_instapay/features/setting_view/data/models/credinitials_model.dart';
import 'package:mini_instapay/features/setting_view/data/repos/setting_repo.dart';

class SettingRepoImpl implements SettingRepo {
  const SettingRepoImpl(this._apiManager);

  final ApiManager _apiManager;

  @override
  Future<Either<Errors, String>> changeCredintials({required CredinitialsModel model}) async {
    if (model.address == UserModel.instance.address &&
        model.lastName == UserModel.instance.lastName &&
        model.phoneNumber == UserModel.instance.mobileNumber &&
        model.firstName == UserModel.instance.firstName) {
      return left(ServerError("You cant submit the same info"));
    }
    try {
      final response = await _apiManager.patch(
        ApiConstants.changeCredintialsEndPoint,
        data: {
          "firstName": model.firstName,
          "lastName": model.lastName,
          "mobileNumber": model.phoneNumber,
          "address": model.address,
        },
        headers: {
          "token": UserModel.instance.token,
        },
      );
      if (response.statusCode! >= 200 && response.statusCode! < 400) {
        try {
          final userDataResponse = await _apiManager.get(
            ApiConstants.getUserData,
            headers: {
              "token": UserModel.instance.token,
            },
          );
          UserModel.instance.setFromjson(userDataResponse.data["data"]);
        } catch (_) {}
      } else {
        return left(ServerError(response.data["message"]));
      }
      return right("Chang");
    } catch (e) {
      if (e is DioException) {
        return left(ServerError.fromDioError(e));
      }
      return left(ServerError(e.toString()));
    }
  }

  @override
  Future<Either<Errors, String>> changeEmail({required String email}) async {
    try {
      final response = await _apiManager.post(
        ApiConstants.changeEmail,
        headers: {
          "token": UserModel.instance.token,
        },
        {
          "email": email,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        UserModel.instance.email = email;
      }
      return right(response.data["token"]);
    } catch (e) {
      if (e is DioException) {
        return left(ServerError.fromDioError(e));
      }
      return left(ServerError(e.toString()));
    }
  }

  @override
  Future<Either<Errors, String>> changePassword({required String oldPass, required String newPass}) async {
    try {
      final response = await _apiManager.patch(
        ApiConstants.updatePassword,
        headers: {
          "token": UserModel.instance.token,
        },
        data: {
          "newPassword": newPass,
          "oldPassword": oldPass,
        },
      );

      if (response.statusCode! >= 200 && response.statusCode! < 400) {
        return right("Updated successfully");
      } else {
        return left(ServerError(response.data["message"]));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerError.fromDioError(e));
      }
      return left(ServerError(e.toString()));
    }
  }

  @override
  Future<Either<Errors, String>> logOut() async {
    try {
      await _apiManager.post(
        ApiConstants.logOut,
        {},
        headers: {
          "token": UserModel.instance.token,
        },
      );
      return right("LogOut successfully");
    } catch (e) {
      if (e is DioException) {
        return left(ServerError.fromDioError(e));
      }
      return left(ServerError(e.toString()));
    }
  }

  @override
  Future<Either<Errors, String>> changeDefault(String id) async {
    try {
      final response = await _apiManager.patch(ApiConstants.changeDefaultAccount, headers: {
        "token": UserModel.instance.token
      }, data: {
        "accountId": id,
      });
      if (response.statusCode! >= 200 && response.statusCode! < 400) {
        return right(response.statusMessage ?? "success");
      } else {
        return left(ServerError(response.data["message"]));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerError(e.response?.data["message"] ?? "error"));
      }
      return left(ServerError("Something went wrong"));
    }
  }

  @override
  Future<Either<Errors, String>> changeLimit({required double limit, required String duration, required accountId}) async {
    try {
      final response = await _apiManager.patch(ApiConstants.changeLimit + accountId, data: {
        "amount": limit,
        "type": duration,
      }, headers: {
        "token": UserModel.instance.token
      });
      if (response.statusCode! >= 200 && response.statusCode! < 400) {
        return right("Limit updated successfully");
      } else {
        return left(ServerError(response.data["message"]));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerError(e.response?.data["message"] ?? "error"));
      }
      return left(ServerError("Something went wrong"));
    }
  }

  @override
  Future<Either<Errors, String>> forgetPin(String id) async {
    try {
      final response = await _apiManager.post(ApiConstants.forgetPin + id, headers: {"token": UserModel.instance.token}, {});

      return right(response.data["token"] ?? "");
    } catch (e) {
      if (e is DioException) {
        return left(ServerError(e.response?.data["message"] ?? "error"));
      }
      print(e.toString());
      return left(ServerError("Something went wrong"));
    }
  }

  @override
  Future<Either<Errors, String>> updatePin(String pin, String userToken) async {
    try {
      final response = await _apiManager.patch(ApiConstants.updateForgetPinOtp, headers: {
        "token": UserModel.instance.token
      }, data: {
        "token": userToken,
        "PIN": pin,
      });
      if (response.statusCode! >= 200 && response.statusCode! < 400) {
        return right(response.statusMessage ?? "success");
      } else {
        return left(ServerError(response.data["message"]));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerError(e.response?.data["message"] ?? "error"));
      }
      return left(ServerError("Something went wrong"));
    }
  }
}
