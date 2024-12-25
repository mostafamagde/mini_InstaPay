import 'package:dartz/dartz.dart';
import 'package:mini_instapay/core/errors/errors.dart';
import 'package:mini_instapay/features/setting_view/data/models/credinitials_model.dart';

abstract class SettingRepo {
  Future<Either<Errors, String>> changeCredintials({required CredinitialsModel model});
  Future<Either<Errors, String>> changePassword({required String oldPass, required String newPass});
  Future<Either<Errors, String>> changeEmail({required String email});
  Future<Either<Errors, String>> logOut();
  Future<Either<Errors, String>> changeDefault(String id);
  Future<Either<Errors, String>> changeLimit({required double limit, required String duration, required accountId});
  Future<Either<Errors, String>> forgetPin(String id);
  Future<Either<Errors, String>> updatePin(String pin, String userToken);
}
