import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mini_instapay/features/account_managment/data/models/bank_model.dart';
import 'package:mini_instapay/features/account_managment/data/repos/all_banks_repo.dart';
import 'package:mini_instapay/features/account_managment/data/repos/all_banks_repo_impl.dart';
import 'package:mini_instapay/features/account_managment/data/repos/save_time.dart';

class BankListProxy implements AllBanksRepo {
  BankListProxy(this.prefs, this.bank);

  final AllBanksRepoImpl bank;
  final SharedPreferences prefs;

  Future<List<BankModel>> getAllBanks() async {
    List<BankModel> list = await getList();
    DateTime? savedDate = await SaveTime.getSavedTime();
    savedDate = savedDate?.add(Duration(minutes: 1));
    DateTime currentDate = DateTime.now();
    if (list.length == 0 || currentDate.isAfter(savedDate!)) {
      list = await bank.getAllBanks();
      await saveList(list);
      await SaveTime.saveCurrentTime();
    }
    return list;
  }

  Future<void> saveList(List<BankModel> bankList) async {
    List<String> jsonList = bankList.map((bank) => jsonEncode(bank.toJson())).toList();

    await prefs.setStringList('bankList', jsonList);
  }

  Future<List<BankModel>> getList() async {
    List<String>? jsonList = prefs.getStringList('bankList');

    if (jsonList != null) {
      return jsonList.map((json) => BankModel.fromJson(jsonDecode(json))).toList();
    }

    return [];
  }
}
