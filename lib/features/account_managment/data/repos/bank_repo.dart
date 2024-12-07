import 'package:flutter/cupertino.dart';
import 'package:untitled2/features/account_managment/data/models/BankAccountModel.dart';
import 'package:untitled2/features/account_managment/data/models/bank_model.dart';

abstract class BankRepository {
  Future<List<BankModel>> getAllBanks();
  Future<BankAccountModel> getAllBankAccounts();
  Future<void> deleteBankAccounts(BankAccountModel model ,int index,TextEditingController inputController);
}

