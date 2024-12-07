import 'package:flutter/cupertino.dart';
import 'package:untitled2/core/api_helper/api_constants.dart';
import 'package:untitled2/core/api_helper/api_manger.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/features/account_managment/data/models/BankAccountModel.dart';

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
  Future<BankAccountModel> getAllBankAccounts() async {
    final response = await ApiManager().get(ApiConstants.addGetBankAccount,
        headers: {"token": UserModel.getInstance().token});

    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      UserModel.getInstance().bankAccounts =
          BankAccountModel.fromJson(response.data);
    }
    return BankAccountModel.fromJson(response.data);
  }

  @override
  Future<void> deleteBankAccounts(BankAccountModel bank, int index,
      TextEditingController inputController) async {
    final date = await ApiManager().delete(
        '${ApiConstants.deleteAccount + bank.data![index].id!}',
        body: {"PIN": inputController.text},
        headers: {"token": UserModel.getInstance().token});
    if (date.statusCode == 200 || date.statusCode == 201) {
     for(var item in UserModel.getInstance().bankAccounts!.data!) {
       if(item.id ==  bank.data![index].id!){
         UserModel.getInstance().bankAccounts!.data!.remove(item);
         break;
       }
     }
    }
  }
}
