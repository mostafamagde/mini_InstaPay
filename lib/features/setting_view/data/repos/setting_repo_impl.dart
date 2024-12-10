import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/features/setting_view/data/models/credinitials_model.dart';
import 'package:untitled2/features/setting_view/data/repos/setting_repo.dart';

import '../../../../core/api_helper/api_constants.dart';
import '../../../../core/api_helper/api_manger.dart';
import '../../../../core/errors/errors.dart';

class SettingRepoImpl implements SettingRepo {
  SettingRepoImpl(ApiManager apiManager);

  @override
  Future<Either<Errors, String>> changeCredintials(
      {required CredinitialsModel model}) async {
    ApiManager service = ApiManager();
    try {
     await service.patch(
        ApiConstants.changeCredintialsEndPoint,
        data: {
          "firstName": model.firstName,
          "lastName": model.lastName,
          "mobileNumber": model.phoneNumber,
          "address": model.address,
        },
        headers: {
          "token": UserModel.getInstance().token,
        },
      );
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
          "token": UserModel.getInstance().token,
        },
        {
          "email": email,
        },
      );
      UserModel.getInstance().userToken = response.data["token"];
      return right("Email Changed Successfully");
    } catch (e) {
      if (e is DioException) {
        return left(ServerError.fromDioError(e));
      }
      return left(ServerError(e.toString()));
    }
  }

  @override
  Future<Either<Errors, String>> changePassword(
      {required String oldPass, required String newPass}) async {
    try {
      ApiManager service = ApiManager();
      await service.patch(
        ApiConstants.updatePassword,
        headers: {
          "token": UserModel.getInstance().token,
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
          "token": UserModel.getInstance().token,
        },
      );
      return Right("LogOut successfully");
    } catch (e) {
      if (e is DioException) {
        return left(ServerError.fromDioError(e));
      }
      return left(ServerError(e.toString()));
    }
  }
}
