import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:untitled2/core/api_helper/api_constants.dart';
import 'package:untitled2/features/transaction_module/data/repos/transaction_repo.dart';

import '../../../../core/api_helper/api_manger.dart';
import '../../../../core/errors/errors.dart';
import '../../../../core/models/user_model.dart';
import '../models/send_model.dart';

class TransactionRepoImpl implements TransactionRepo {

  ApiManager service;
  TransactionRepoImpl(this.service);
  @override
  Future<Either<Errors,String>> sendMoney(SendModel send) async {

    try {
     final response= await service.post(ApiConstants.sendMoney, {
        "receiverData": send.reiceverData,
        "PIN": send.pin,
        "amount": send.amount,
       "accountId":send.account??null,
      }, headers: {
        "token": UserModel.getInstance().token,
      });
     return right(response.statusMessage??"success");
    } catch (e) {
      if (e is DioException) {
        return Left(ServerError(e.response?.data["message"]??"error"));
      } else {
        return left(ServerError("Something went wrong"));
      }
    }
  }
}
