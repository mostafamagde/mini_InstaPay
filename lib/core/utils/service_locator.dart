import 'package:get_it/get_it.dart';
import 'package:untitled2/features/account_managment/data/repos/bank_repo_impl.dart';

import '../../features/setting_view/data/repos/setting_repo_impl.dart';
import '../api_helper/api_manger.dart';

class ServiceLocator {
  static var getIt = GetIt.instance;

  static void setup() {
    getIt.registerSingleton<ApiManager>(ApiManager());
    getIt.registerSingleton<SettingRepoImpl>(
        SettingRepoImpl(getIt.get<ApiManager>()));
    getIt.registerSingleton<BankRepoImpl>(BankRepoImpl());
  }
}
