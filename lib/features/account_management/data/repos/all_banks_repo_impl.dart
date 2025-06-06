import 'package:mini_instapay/core/api_helper/api_constants.dart';
import 'package:mini_instapay/core/api_helper/api_manger.dart';
import 'package:mini_instapay/features/account_management/data/models/bank_model.dart';
import 'package:mini_instapay/features/account_management/data/repos/all_banks_repo.dart';

class AllBanksRepoImpl extends AllBanksRepo {
  AllBanksRepoImpl(this._apiManager);

  final ApiManager _apiManager;

  @override
  Future<List<BankModel>> getAllBanks() async {
    final response = await _apiManager.get(ApiConstants.getAllBanks);
    final List<dynamic> data = response.data;
    return data.map((json) => BankModel.fromJson(json)).toList();
  }
}
