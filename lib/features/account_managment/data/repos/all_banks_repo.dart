import 'package:mini_instapay/features/account_managment/data/models/bank_model.dart';

abstract class AllBanksRepo {
  Future<List<BankModel>> getAllBanks();
}
