import 'package:get_it/get_it.dart';
import 'package:untitled2/core/api_helper/api_manger.dart';
import 'package:untitled2/features/account_managment/data/repos/bank_repo_impl.dart';
import 'package:untitled2/features/reports/data/repo_impl/admin_transactions_summary_repo_impl.dart';
import 'package:untitled2/features/reports/data/repo_impl/one_user_transactions_repo_impl.dart';
import 'package:untitled2/features/reports/data/repo_impl/user_transactions_summary_repo_impl.dart';
import 'package:untitled2/features/reports/domain/use_cases/get_annual_transactions.dart';
import 'package:untitled2/features/reports/domain/use_cases/get_each_user_transactions.dart';
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
    getIt.registerSingleton<UserTransactionsSummaryRepoImpl>(UserTransactionsSummaryRepoImpl());
    getIt.registerSingleton<AdminTransactionsSummaryRepoImpl>(AdminTransactionsSummaryRepoImpl());
    getIt.registerSingleton<GetMonthlyTransactions>(GetMonthlyTransactions(getIt<TransactionRepository>(), getIt<UserTransactionsSummaryRepoImpl>(), getIt<AdminTransactionsSummaryRepoImpl>()));
    getIt.registerSingleton<GetAnnualTransactions>(GetAnnualTransactions(getIt<TransactionRepository>(), getIt<UserTransactionsSummaryRepoImpl>(), getIt<AdminTransactionsSummaryRepoImpl>()));
    getIt.registerSingleton<OneUserTransactionsRepoImpl>(OneUserTransactionsRepoImpl());
    getIt.registerSingleton<GetEachUserTransactions>(GetEachUserTransactions(getIt<TransactionRepository>(), getIt<OneUserTransactionsRepoImpl>()));
  }
}
