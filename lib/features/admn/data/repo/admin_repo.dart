import 'package:dartz/dartz.dart';
import 'package:untitled2/core/errors/errors.dart';
import 'package:untitled2/features/admn/data/models/AdminUsersModel.dart';


abstract class AdminRepo {
  Future<Either<ServerError, List<AdminUsersModel>>> getUsers([String? search]);
  Future<Either<ServerError, String>> banUsers(String id);
}
