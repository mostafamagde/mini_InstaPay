import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:untitled2/core/api_helper/api_constants.dart';
import 'package:untitled2/core/api_helper/api_manger.dart';
import 'package:untitled2/core/errors/errors.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/features/transaction_module/data/models/receive_model.dart';
import 'package:untitled2/features/transaction_module/data/models/send_model.dart';
import 'package:untitled2/features/transaction_module/data/repos/transaction_repo.dart';

class TransactionRepoImpl implements TransactionRepo {
  TransactionRepoImpl(this.service);

  ApiManager service;

  @override
  Future<Either<Errors, String>> sendMoney(SendModel send) async {
    try {
      final response = await service.post(ApiConstants.sendMoney, {
        "receiverData": send.reiceverData,
        "PIN": send.pin,
        "amount": send.amount,
        "accountId": send.account ?? null,
      }, headers: {
        "token": UserModel.getInstance().token,
      });
      return right(response.statusMessage ?? "success");
    } catch (e) {
      if (e is DioException) {
        return Left(ServerError(e.response?.data["message"] ?? "error"));
      } else {
        return left(ServerError("Something went wrong"));
      }
    }
  }

  @override
  Future<Either<Errors, String>> receiveMoney(ReceiveModel receive) async {
    try {
      final response = await service.post(ApiConstants.receiveMoney, {
        "reciverData": receive.receiveData,
        "amount": receive.amount,
        "accountId": receive.accountId ?? null,
      }, headers: {
        "token": UserModel.getInstance().token,
      });
      return right(response.statusMessage ?? "success");
    } catch (e) {
      if (e is DioException) {
        return Left(ServerError(e.response?.data["message"] ?? "error"));
      } else {
        return left(ServerError("Something went wrong"));
      }
    }
  }
}
