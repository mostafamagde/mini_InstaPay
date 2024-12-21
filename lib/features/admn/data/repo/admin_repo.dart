import 'package:dartz/dartz.dart';
import 'package:untitled2/core/errors/errors.dart';

import '../models/AdminUsersModel.dart';

abstract class AdminRepo {
 Future<Either<ServerError,List<AdminUsersModel>>> getUsers();
}