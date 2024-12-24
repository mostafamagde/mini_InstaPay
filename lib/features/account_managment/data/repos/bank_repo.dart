import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled2/core/errors/errors.dart';
import 'package:untitled2/features/account_managment/data/models/account_data.dart';
import 'package:untitled2/features/account_managment/data/models/add_account_model.dart';
import 'package:untitled2/features/account_managment/data/models/bank_model.dart';

abstract class BankRepository {
  Future<List<BankModel>> getAllBanks();
  Future<List<BankAccountData>> getAllBankAccounts();
  Future<void> deleteBankAccounts(List<BankAccountData> models, int index, TextEditingController inputController);
  Future<int> getBalance(String accId, String pin);
  Future<void> addAccount(AddAccountModel account);
  Future<Either<ServerError, String>> changePin(String oldPin, String newPin, String accId);
}
