import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:mini_instapay/features/otp/data/repositories/otp_factory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mini_instapay/core/api_helper/api_manger.dart';
import 'package:mini_instapay/features/account_managment/data/repos/all_banks_repo_impl.dart';
import 'package:mini_instapay/features/account_managment/data/repos/bank_repo_impl.dart';
import 'package:mini_instapay/features/admn/data/repo/admin_repo_impl.dart';
import 'package:mini_instapay/features/auth/data/repository/auth_repo_impl.dart';
import 'package:mini_instapay/features/notifications/data/repository/notifications_repo.dart';
import 'package:mini_instapay/features/reports/data/repo_impl/admin_transactions_summary_repo_impl.dart';
import 'package:mini_instapay/features/reports/data/repo_impl/one_user_transactions_repo_impl.dart';
import 'package:mini_instapay/features/reports/data/repo_impl/user_transactions_summary_repo_impl.dart';
import 'package:mini_instapay/features/reports/domain/use_cases/get_annual_transactions.dart';
import 'package:mini_instapay/features/reports/domain/use_cases/get_each_user_transactions.dart';
import 'package:mini_instapay/features/reports/domain/use_cases/get_monthly_transactions.dart';
import 'package:mini_instapay/features/setting_view/data/repos/setting_repo_impl.dart';
import 'package:mini_instapay/features/transaction_module/data/repos/transaction_repo_impl.dart';
import 'package:mini_instapay/features/transactions/data/repository/transaction_repo.dart';

class ServiceLocator {
  static final GetIt getIt = GetIt.instance;

  static Future<void> setup() async {
    getIt.registerSingleton<Dio>(Dio());
    getIt.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());
    getIt.registerSingleton<ApiManager>(ApiManager(getIt.get<Dio>()));
    getIt.registerSingleton<OtpFactory>(OtpFactory());
    getIt.registerSingleton<SettingRepoImpl>(SettingRepoImpl(getIt.get<ApiManager>()));
    getIt.registerSingleton<NotificationsRepo>(NotificationsRepo(getIt.get<ApiManager>()));
    getIt.registerSingleton<BankRepoImpl>(BankRepoImpl(getIt.get<ApiManager>()));
    getIt.registerSingleton<AllBanksRepoImpl>(AllBanksRepoImpl(getIt.get<ApiManager>()));
    getIt.registerSingleton<AuthRepoImpl>(AuthRepoImpl(getIt.get<ApiManager>()));
    getIt.registerSingleton<AdminRepoImpl>(AdminRepoImpl(getIt.get<ApiManager>()));
    getIt.registerSingleton<TransactionRepoImpl>(TransactionRepoImpl(getIt.get<ApiManager>()));
    getIt.registerSingleton<TransactionRepository>(TransactionRepository(getIt.get<ApiManager>()));
    getIt.registerSingleton<UserTransactionsSummaryRepoImpl>(UserTransactionsSummaryRepoImpl());
    getIt.registerSingleton<AdminTransactionsSummaryRepoImpl>(AdminTransactionsSummaryRepoImpl());
    getIt.registerSingleton<GetMonthlyTransactions>(GetMonthlyTransactions(getIt<TransactionRepository>(), getIt<UserTransactionsSummaryRepoImpl>(), getIt<AdminTransactionsSummaryRepoImpl>()));
    getIt.registerSingleton<GetAnnualTransactions>(GetAnnualTransactions(getIt<TransactionRepository>(), getIt<UserTransactionsSummaryRepoImpl>(), getIt<AdminTransactionsSummaryRepoImpl>()));
    getIt.registerSingleton<OneUserTransactionsRepoImpl>(OneUserTransactionsRepoImpl());
    getIt.registerSingleton<GetEachUserTransactions>(GetEachUserTransactions(getIt<TransactionRepository>(), getIt<OneUserTransactionsRepoImpl>()));
    getIt.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
  }
}
