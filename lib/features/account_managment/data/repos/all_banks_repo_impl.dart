import 'package:mini_instapay/core/api_helper/api_constants.dart';
import 'package:mini_instapay/core/api_helper/api_manger.dart';
import 'package:mini_instapay/features/account_managment/data/models/bank_model.dart';
import 'package:mini_instapay/features/account_managment/data/repos/all_banks_repo.dart';

class AllBanksRepoImpl extends AllBanksRepo {
  @override
  Future<List<BankModel>> getAllBanks() async {
    final response = await ApiManager().get(ApiConstants.getAllBanks);
    final List<dynamic> data = response.data;
    return data.map((json) => BankModel.fromJson(json)).toList();
  }
}
