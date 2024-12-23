import 'package:get_it/get_it.dart';
import 'package:untitled2/core/api_helper/api_manger.dart';
import 'package:untitled2/features/account_managment/data/repos/bank_repo_impl.dart';
import 'package:untitled2/features/setting_view/data/repos/setting_repo_impl.dart';
import 'package:untitled2/features/transaction_module/data/repos/transaction_repo_impl.dart';

class ServiceLocator {
  static final GetIt getIt = GetIt.instance;

  static void setup() {
    getIt.registerSingleton<ApiManager>(ApiManager());
    getIt.registerSingleton<SettingRepoImpl>(SettingRepoImpl(getIt.get<ApiManager>()));
    getIt.registerSingleton<BankRepoImpl>(BankRepoImpl());
    getIt.registerSingleton<TransactionRepoImpl>(TransactionRepoImpl(getIt.get<ApiManager>()));

  }
}
