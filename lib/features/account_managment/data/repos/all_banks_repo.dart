import 'package:untitled2/features/account_managment/data/models/bank_model.dart';

abstract class AllBanksRepo {
  Future<List<BankModel>> getAllBanks();
}
