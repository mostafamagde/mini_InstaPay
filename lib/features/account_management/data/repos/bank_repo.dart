import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:mini_instapay/core/errors/errors.dart';
import 'package:mini_instapay/features/account_management/data/models/account_data.dart';
import 'package:mini_instapay/features/account_management/data/models/add_account_model.dart';

abstract class BankRepository {
  Future<List<BankAccountData>> getAllBankAccounts();
  Future<void> deleteBankAccounts(List<BankAccountData> models, int index, TextEditingController inputController);
  Future<int> getBalance(String accId, String pin);
  Future<void> addAccount(AddAccountModel account);
  Future<Either<ServerError, String>> changePin(String oldPin, String newPin, String accId);
}
