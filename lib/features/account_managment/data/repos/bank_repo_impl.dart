import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled2/core/api_helper/api_constants.dart';
import 'package:untitled2/core/api_helper/api_manger.dart';
import 'package:untitled2/core/errors/errors.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/features/account_managment/data/models/account_data.dart';
import 'package:untitled2/features/account_managment/data/models/add_account_model.dart';
import 'package:untitled2/features/account_managment/data/models/bank_model.dart';
import 'bank_repo.dart';

class BankRepoImpl implements BankRepository {
  @override
  Future<List<BankModel>> getAllBanks() async {
    final response = await ApiManager().get(ApiConstants.getAllBanks);
    final List<dynamic> data = response.data;
    return data.map((json) => BankModel.fromJson(json)).toList();
  }

  @override
  Future<List<BankAccountData>> getAllBankAccounts() async {
    final response = await ApiManager().get(ApiConstants.addGetBankAccount, headers: {"token": UserModel.instance.token});

    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      UserModel.instance.bankAccounts = List.generate(response.data['data'].length, (int index) => BankAccountData.fromJson(response.data['data'][index]));
      return UserModel.instance.bankAccounts ?? [];
    }
    return [];
  }

  @override
  Future<void> deleteBankAccounts(List<BankAccountData> banks, int index, TextEditingController inputController) async {
    final date = await ApiManager().delete('${ApiConstants.deleteAccount + banks[index].id!}', body: {"PIN": inputController.text}, headers: {"token": UserModel.instance.token});
    if (date.statusCode == 200 || date.statusCode == 201) {
      if (UserModel.instance.bankAccounts != null) {
        UserModel.instance.bankAccounts!.removeWhere((element) => element.id == banks[index].id!);
      }
    }
  }

  @override
  Future<int> getBalance(String accId, String pin) async {
    final data = await ApiManager().post("${ApiConstants.getBalance}${accId}", {
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
    final response = await ApiManager().post(
      ApiConstants.addGetBankAccount,
      {
        "holderName": account.cardHolderName,
        "bankId": account.bankId,
        "cardNo": account.cardNumber,
        "date": {
          "year": "20" + account.expirationDate.split("/")[1],
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
        final apiManager = ApiManager();
        final userDataResponse = await apiManager.get(
          ApiConstants.getUserData,
          headers: {
            "token": UserModel.instance.token,
          },
        );
        UserModel.instance.setFromjson(userDataResponse.data["data"]);
      } catch (e) {}
    }
  }

  @override
  Future<Either<ServerError, String>> changePin(String oldPin, String newPin, String accId) async {
    try {
      final response = await ApiManager().patch(ApiConstants.updatePin + accId, headers: {
        "token": UserModel.instance.token
      }, data: {
        "oldPIN": oldPin,
        "newPIN": newPin,
      });
      return right(response.statusMessage ?? "PIN updated");
    } catch (e) {
      if (e is DioException) {
        return Left(ServerError(e.response?.data["message"] ?? "error"));
      } else {
        return left(ServerError("Something went wrong"));
      }
    }
  }
}
