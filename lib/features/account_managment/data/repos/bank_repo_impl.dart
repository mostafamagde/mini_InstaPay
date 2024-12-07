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

    return  BankAccountModel.fromJson(response.data);

  }
}
