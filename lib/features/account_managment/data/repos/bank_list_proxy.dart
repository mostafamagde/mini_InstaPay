import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled2/features/account_managment/data/models/bank_model.dart';
import 'package:untitled2/features/account_managment/data/repos/bank_repo_impl.dart';
import 'package:untitled2/features/account_managment/data/repos/save_time.dart';

class BankListProxy {
  Future<List<BankModel>> getBankList() async {
    List<BankModel> list = await getLIst();
    DateTime? savedDate = await SaveTime.getSavedTime();
    savedDate = savedDate?.add(Duration(minutes: 1));
    DateTime currentDate = DateTime.now();
    if (list.length == 0 || currentDate.isAfter(savedDate!)) {
      BankRepoImpl bank = BankRepoImpl();
      list = await bank.getAllBanks();
      await saveList(list);
      await SaveTime.saveCurrentTime();
    }
    return list;
  }

  Future<void> saveList(List<BankModel> bankList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> jsonList =
        bankList.map((bank) => jsonEncode(bank.toJson())).toList();

    await prefs.setStringList('bankList', jsonList);
  }

  Future<List<BankModel>> getLIst() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? jsonList = prefs.getStringList('bankList');

    if (jsonList != null) {
      return jsonList
          .map((json) => BankModel.fromJson(jsonDecode(json)))
          .toList();
    }

    return [];
  }
}
