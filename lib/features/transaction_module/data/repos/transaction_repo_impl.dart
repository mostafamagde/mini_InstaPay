import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mini_instapay/core/api_helper/api_constants.dart';
import 'package:mini_instapay/core/api_helper/api_manger.dart';
import 'package:mini_instapay/core/errors/errors.dart';
import 'package:mini_instapay/core/models/user_model.dart';
import 'package:mini_instapay/features/transaction_module/data/models/receive_model.dart';
import 'package:mini_instapay/features/transaction_module/data/models/send_model.dart';
import 'package:mini_instapay/features/transaction_module/data/repos/transaction_repo.dart';

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
        "accountId": send.account,
      }, headers: {
        "token": UserModel.instance.token,
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
        "receiveData": receive.receiveData,
        "amount": receive.amount,
        "accountId": receive.accountId,
      }, headers: {
        "token": UserModel.instance.token,
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
