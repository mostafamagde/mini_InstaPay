import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mini_instapay/core/api_helper/api_constants.dart';
import 'package:mini_instapay/core/api_helper/api_manger.dart';
import 'package:mini_instapay/core/errors/errors.dart';
import 'package:mini_instapay/core/models/user_model.dart';
import 'package:mini_instapay/features/account_management/data/models/account_data.dart';
import 'package:mini_instapay/features/account_management/data/models/add_account_model.dart';
import 'bank_repo.dart';

class BankRepoImpl implements BankRepository {
  const BankRepoImpl(this._apiManager);

  final ApiManager _apiManager;

  @override
  Future<List<BankAccountData>> getAllBankAccounts() async {
    final response = await _apiManager.get(ApiConstants.addGetBankAccount, headers: {"token": UserModel.instance.token});

    if (response.statusCode == 200 || response.statusCode == 201) {
      UserModel.instance.bankAccounts = List.generate(response.data['data'].length, (int index) => BankAccountData.fromJson(response.data['data'][index]));
      return UserModel.instance.bankAccounts ?? [];
    }
    return [];
  }

  @override
  Future<void> deleteBankAccounts(List<BankAccountData> banks, int index, TextEditingController inputController) async {
    final date = await _apiManager.delete(ApiConstants.deleteAccount + banks[index].id!, body: {"PIN": inputController.text}, headers: {"token": UserModel.instance.token});
    if (date.statusCode == 200 || date.statusCode == 201) {
      if (UserModel.instance.bankAccounts != null) {
        UserModel.instance.bankAccounts!.removeWhere((element) => element.id == banks[index].id!);
      }
    }
  }

  @override
  Future<int> getBalance(String accId, String pin) async {
    final data = await _apiManager.post("${ApiConstants.getBalance}$accId", {
      "PIN": pin
    }, headers: {
      "token": UserModel.instance.token,
    });
    if (data.statusCode == 200 || data.statusCode == 201) {
      return data.data['data'];
    } else {
      return 10;
    }
  }

  @override
  Future<void> addAccount(AddAccountModel account) async {
    final response = await _apiManager.post(
      ApiConstants.addGetBankAccount,
      {
        "holderName": account.cardHolderName,
        "bankId": account.bankId,
        "cardNo": account.cardNumber,
        "date": {
          "year": "20${account.expirationDate.split("/")[1]}",
          "month": account.expirationDate.split("/")[0],
        },
        "CVV": account.cvv,
        "PIN": account.pin
      },
      headers: {
        "token": UserModel.instance.token,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        final userDataResponse = await _apiManager.get(
          ApiConstants.getUserData,
          headers: {
            "token": UserModel.instance.token,
          },
        );
        UserModel.instance.setFromjson(userDataResponse.data["data"]);
      } catch (_) {}
    }
  }

  @override
  Future<Either<ServerError, String>> changePin(String oldPin, String newPin, String accId) async {
    try {
      final response = await _apiManager.patch(ApiConstants.updatePin + accId, headers: {
        "token": UserModel.instance.token
      }, data: {
        "oldPIN": oldPin,
        "newPIN": newPin,
      });
      return right(response.statusMessage ?? "PIN updated");
    } catch (e) {
      if (e is DioException) {
        return left(ServerError(e.response?.data["message"] ?? "error"));
      } else {
        return left(ServerError("Something went wrong"));
      }
    }
  }
}
