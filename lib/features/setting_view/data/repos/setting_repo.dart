import 'package:dartz/dartz.dart';
import 'package:untitled2/core/errors/errors.dart';
import 'package:untitled2/features/setting_view/data/models/credinitials_model.dart';

abstract class SettingRepo {
  Future<Either<Errors, String>> changeCredintials({required CredinitialsModel model});
  Future<Either<Errors, String>> changePassword({required String oldPass, required String newPass});
  Future<Either<Errors, String>> changeEmail({required String email});
  Future<Either<Errors, String>> logOut();
  Future<Either<Errors, String>> changeDefault(String id);
}
