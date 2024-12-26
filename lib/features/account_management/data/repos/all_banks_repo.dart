import 'package:mini_instapay/features/account_management/data/models/bank_model.dart';

abstract class AllBanksRepo {
  Future<List<BankModel>> getAllBanks();
}
