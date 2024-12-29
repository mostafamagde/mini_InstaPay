import 'package:dartz/dartz.dart';
import 'package:mini_instapay/core/errors/errors.dart';
import 'package:mini_instapay/features/admin/data/models/AdminUsersModel.dart';

abstract class AdminRepo {
  Future<Either<ServerError, List<AdminUsersModel>>> getUsers([String? search]);
  Future<Either<ServerError, String>> banUsers(AdminUsersModel id);
}