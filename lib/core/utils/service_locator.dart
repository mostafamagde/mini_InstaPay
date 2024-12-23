import 'package:get_it/get_it.dart';
import 'package:untitled2/core/api_helper/api_manger.dart';
import 'package:untitled2/features/account_managment/data/repos/bank_repo_impl.dart';
import 'package:untitled2/features/reports/data/repo_impl/transactions_summary_repo_impl.dart';
import 'package:untitled2/features/reports/domain/use_cases/get_annual_transactions.dart';
import 'package:untitled2/features/reports/domain/use_cases/get_monthly_transactions.dart';
import 'package:untitled2/features/setting_view/data/repos/setting_repo_impl.dart';
import 'package:untitled2/features/transaction_module/data/repos/transaction_repo_impl.dart';
import 'package:untitled2/features/transactions/data/repository/transaction_repo.dart';

class ServiceLocator {
  static final GetIt getIt = GetIt.instance;

  static void setup() {
    getIt.registerSingleton<ApiManager>(ApiManager());
    getIt.registerSingleton<SettingRepoImpl>(SettingRepoImpl(getIt.get<ApiManager>()));
    getIt.registerSingleton<BankRepoImpl>(BankRepoImpl());
    getIt.registerSingleton<TransactionRepoImpl>(TransactionRepoImpl(getIt.get<ApiManager>()));
    getIt.registerSingleton<TransactionRepository>(TransactionRepository(getIt.get<ApiManager>()));
    getIt.registerSingleton<TransactionsSummaryRepoImpl>(TransactionsSummaryRepoImpl());
    getIt.registerSingleton<GetMonthlyTransactions>(GetMonthlyTransactions(getIt<TransactionRepository>(), getIt<TransactionsSummaryRepoImpl>()));
    getIt.registerSingleton<GetAnnualTransactions>(GetAnnualTransactions(getIt<TransactionRepository>(), getIt<TransactionsSummaryRepoImpl>()));
  }
}
