import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:untitled2/core/api_helper/api_constants.dart';
import 'package:untitled2/core/api_helper/api_manger.dart';
import 'package:untitled2/core/errors/errors.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/features/setting_view/data/models/credinitials_model.dart';
import 'package:untitled2/features/setting_view/data/repos/setting_repo.dart';

class SettingRepoImpl implements SettingRepo {
  SettingRepoImpl(ApiManager apiManager);

  @override
  Future<Either<Errors, String>> changeCredintials({required CredinitialsModel model}) async {
    ApiManager service = ApiManager();
    if (model.address == UserModel.instance.address &&
        model.lastName == UserModel.instance.lastName &&
        model.phoneNumber == UserModel.instance.mobileNumber &&
        model.firstName == UserModel.instance.firstName) {
      return left(ServerError("You cant submit the same info"));
    }
    try {
      final response = await service.patch(
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
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final apiManager = ApiManager();
          final userDataResponse = await apiManager.get(
            ApiConstants.getUserData,
            headers: {
              "token": UserModel.instance.token,
            },
          );
          UserModel.instance.setFromjson(userDataResponse.data["data"]);
        } catch (e) {}
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
    ApiManager service = ApiManager();
    try {
      final response = await service.post(
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
      ApiManager service = ApiManager();
      await service.patch(
        ApiConstants.updatePassword,
        headers: {
          "token": UserModel.instance.token,
        },
        data: {
          "newPassword": newPass,
          "oldPassword": oldPass,
        },
      );
      return Right("Updated successfully");
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
      ApiManager service = ApiManager();
      await service.post(
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
      ApiManager service = ApiManager();
      final response = await service.patch(ApiConstants.ChangeDefaultAccount, headers: {
        "token": UserModel.instance.token
      }, data: {
        "accountId": id,
      });
      return right(response.statusMessage ?? "success");
    } catch (e) {
      if (e is DioException) {
        return left(ServerError(e.response?.data["message"] ?? "error"));
      }
      return left(ServerError("Something went wrong"));
    }
  }

  @override
  Future<Either<Errors, String>> changeLimit(
      {required double limit,
      required String duration,
      required accountId}) async {
    try {
      final apiManger = ApiManager();
      await apiManger.patch(ApiConstants.changeLimit + accountId, data: {
        "amount": limit,
        "type": duration,
      }, headers: {
        "token": UserModel.instance.token
      });
      return right("Limit updated successfully");
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
      print(UserModel.instance.token);
      final apiManger = ApiManager();
      final response = await apiManger.post(
          ApiConstants.forgetPin + id,
          headers: {"token": UserModel.instance.token},
          {});

      return right(response.data["token"]);
    } catch (e) {
      if (e is DioException) {
        print (e.response!.statusCode);
        return left(ServerError(e.response?.data["message"] ?? "error"));
      }
      return left(ServerError("Something went wrong"));
    }
  }

  @override
  Future<Either<Errors, String>> updatePin(String pin, String userToken) async {
    try {
      ApiManager service = ApiManager();
      final response =
          await service.patch(ApiConstants.updateForgetPinOtp, headers: {
        "token": UserModel.instance.token
      }, data: {
        "token": userToken,
        "PIN": pin,
      });
      return right(response.statusMessage ?? "success");
    } catch (e) {
      if (e is DioException) {
        return left(ServerError(e.response?.data["message"] ?? "error"));
      }
      return left(ServerError("Something went wrong"));
    }
  }
}
