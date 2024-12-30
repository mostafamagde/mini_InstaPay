import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mini_instapay/features/account_management/data/models/bank_model.dart';
import 'package:mini_instapay/features/account_management/data/repos/all_banks_repo.dart';
import 'package:mini_instapay/features/account_management/data/repos/save_time.dart';

class BankListProxy implements AllBanksRepo {
  const BankListProxy(this._sharedPreferences, this._allBanksRepo, this._timeSaving);

  final AllBanksRepo _allBanksRepo;
  final SharedPreferences _sharedPreferences;
  final TimeSaving _timeSaving;

  @override
  Future<List<BankModel>> getAllBanks() async {
    List<BankModel> list = await getList();
    DateTime? savedDate = await _timeSaving.getSavedTime();
    savedDate = savedDate?.add(Duration(minutes: 1));
    DateTime currentDate = DateTime.now();
    if (list.isEmpty || currentDate.isAfter(savedDate!)) {
      list = await _allBanksRepo.getAllBanks();
      await saveList(list);
      await _timeSaving.saveCurrentTime();
    }
    return list;
  }

  Future<void> saveList(List<BankModel> bankList) async {
    List<String> jsonList = bankList.map((bank) => jsonEncode(bank.toJson())).toList();

    await _sharedPreferences.setStringList('bankList', jsonList);
  }

  Future<List<BankModel>> getList() async {
    List<String>? jsonList = _sharedPreferences.getStringList('bankList');

    if (jsonList != null) {
      return jsonList.map((json) => BankModel.fromJson(jsonDecode(json))).toList();
    }

    return [];
  }
}
