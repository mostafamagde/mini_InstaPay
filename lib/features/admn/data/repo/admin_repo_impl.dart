import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:untitled2/core/api_helper/api_constants.dart';
import 'package:untitled2/core/api_helper/api_manger.dart';
import 'package:untitled2/features/admn/data/models/AdminUsersModel.dart';
import 'package:untitled2/features/admn/data/repo/admin_repo.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/models/user_model.dart';

class AdminRepoImpl implements AdminRepo {
  ApiManager service = ApiManager();

  @override
  Future<Either<ServerError, List<AdminUsersModel>>> getUsers([String? search]) async {
    try {
      final data = await service.get(ApiConstants.allUsersAdmin, headers: {"token": UserModel.instance.token});
      final usersList = (data.data as List).map((e) => AdminUsersModel.fromJson(e)).toList();
      if (search == null || search.trim().isEmpty) {
        return right(usersList);
      } else {
        List<AdminUsersModel> filterd = [];
        for (var item in usersList) {
          if (item.email!.toLowerCase().contains(search.toLowerCase()) ||
              item.mobileNumber!.toLowerCase().contains(search.toLowerCase()) ||
              item.userName!.toLowerCase().contains(search.toLowerCase()) ||
              item.id!.toLowerCase().contains(search.toLowerCase())) {
            filterd.add(item);
          }
        }
        return right(filterd);
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerError.fromDioError(e));
      }
      return left(ServerError(e.toString()));
    }
  }

  @override
  Future<Either<ServerError, String>> banUsers(String id) async {
    try {
      final data = await service.post(ApiConstants.banUsersAdmin, {"userId": id}, headers: {"token": UserModel.instance.token});
      return right(data.data["message"] ?? "banned Succeeded");
    } catch (e) {
      if (e is DioException) {
        return left(ServerError.fromDioError(e));
      }
      return left(ServerError(e.toString()));
    }
  }
}
