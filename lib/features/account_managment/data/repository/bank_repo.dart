import 'package:untitled2/features/account_managment/data/bank_model.dart';

abstract class BankRepository {
  Future<List<BankModel>> getAllBanks();
}

