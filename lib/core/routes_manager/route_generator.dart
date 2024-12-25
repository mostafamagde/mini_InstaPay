import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled2/core/navigation_cubit/navigation_cubit.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/service_locator.dart';
import 'package:untitled2/features/account_managment/data/repos/all_banks_repo_impl.dart';
import 'package:untitled2/features/account_managment/data/repos/bank_list_proxy.dart';
import 'package:untitled2/features/account_managment/data/repos/bank_repo_impl.dart';
import 'package:untitled2/features/account_managment/presentation/manager/add_account/add_account_cubit.dart';
import 'package:untitled2/features/account_managment/presentation/manager/balance_cubit/get_balance_cubit.dart';
import 'package:untitled2/features/account_managment/presentation/manager/change_pin_cubit/change_pin_cubit.dart';
import 'package:untitled2/features/account_managment/presentation/manager/get_all_banks/banks_cubit.dart';
import 'package:untitled2/features/account_managment/presentation/manager/manage_user_bank_accounts/manage_bank_accounts_cubit.dart';
import 'package:untitled2/features/account_managment/presentation/views/add_bank_account.dart';
import 'package:untitled2/features/account_managment/presentation/views/change_pin_view.dart';
import 'package:untitled2/features/account_managment/presentation/views/choose_bank_account_view.dart';
import 'package:untitled2/features/account_managment/presentation/views/manage_accounts.dart';
import 'package:untitled2/features/account_managment/presentation/views/pin_view.dart';
import 'package:untitled2/features/admn/data/repo/admin_repo_impl.dart';
import 'package:untitled2/features/admn/presentation/manager/ban_users_cubit/ban_users_cubit.dart';
import 'package:untitled2/features/admn/presentation/manager/get_users_cubit/admin_get_users_cubit.dart';
import 'package:untitled2/features/admn/presentation/views/admin_layout.dart';
import 'package:untitled2/features/admn/presentation/views/admin_setting.dart';
import 'package:untitled2/features/admn/presentation/views/all_users_view.dart';
import 'package:untitled2/features/auth/data/repository/auth_repo_impl.dart';
import 'package:untitled2/features/auth/presentation/manger/auth_cubit/auth_cubit.dart';
import 'package:untitled2/features/auth/presentation/views/enter_password_view.dart';
import 'package:untitled2/features/auth/presentation/views/forget_password_view.dart';
import 'package:untitled2/features/auth/presentation/views/login_view.dart';
import 'package:untitled2/features/auth/presentation/views/signup_view.dart';
import 'package:untitled2/features/home_view/presentation/views/home_view.dart';
import 'package:untitled2/features/reports/domain/use_cases/get_annual_transactions.dart';
import 'package:untitled2/features/reports/domain/use_cases/get_each_user_transactions.dart';
import 'package:untitled2/features/reports/domain/use_cases/get_monthly_transactions.dart';
import 'package:untitled2/features/reports/presentation/manager/transaction_summary_view_cubit/transaction_summary_view_cubit.dart';
import 'package:untitled2/features/reports/presentation/manager/usage_analysis_cubit/usage_analysis_cubit.dart';
import 'package:untitled2/features/reports/presentation/views/account_usage_analysis_screen.dart';
import 'package:untitled2/features/reports/presentation/views/analytics_view.dart';
import 'package:untitled2/features/reports/presentation/views/transactions_summary_screen.dart';
import 'package:untitled2/features/setting_view/presentation/manager/change_limit/change_limit_cubit.dart';
import 'package:untitled2/features/setting_view/presentation/manager/confirm_forget_pin/cinfirm_forget_pin_cubit.dart';
import 'package:untitled2/features/setting_view/presentation/manager/forget_pin_cubit/forget_pin_cubit.dart';
import 'package:untitled2/features/setting_view/presentation/manager/log_out_cubit/log_out_cubit.dart';
import 'package:untitled2/features/setting_view/presentation/views/change_limit.dart';
import 'package:untitled2/features/setting_view/presentation/views/forget_pin.dart';
import 'package:untitled2/features/setting_view/presentation/views/setting_view.dart';
import 'package:untitled2/features/splash_view/presentation/views/splash_view.dart';
import 'package:untitled2/features/transaction_module/data/repos/transaction_repo_impl.dart';
import 'package:untitled2/features/transaction_module/presentation/manager/receive_cubit/receive_cubit.dart';
import 'package:untitled2/features/transaction_module/presentation/manager/send_cubit/send_cubit.dart';
import 'package:untitled2/features/transaction_module/presentation/views/receive_money_view.dart';
import 'package:untitled2/features/transaction_module/presentation/views/send_money_view.dart';
import 'package:untitled2/features/transaction_module/presentation/views/send_pin.dart';
import 'package:untitled2/features/transactions/data/repository/transaction_repo.dart';
import 'package:untitled2/features/transactions/presentation/manger/cubit/transaction_cubit.dart';
import 'package:untitled2/features/transactions/presentation/views/all_transaction_view.dart';
import 'package:untitled2/features/layout_view/presentation/views/layout_view.dart';
import 'package:untitled2/features/notifications/data/repository/notifications_repo.dart';
import 'package:untitled2/features/notifications/presentation/manger/notifications/notifications_cubit.dart';
import 'package:untitled2/features/notifications/presentation/views/notification_pin_view.dart';
import 'package:untitled2/features/notifications/presentation/views/notifications_view.dart';
import 'package:untitled2/features/onboarding/presentation/manger/on_boarding/on_boarding_cubit.dart';
import 'package:untitled2/features/onboarding/presentation/views/on_boarding_view.dart';
import 'package:untitled2/features/setting_view/data/repos/setting_repo_impl.dart';
import 'package:untitled2/features/setting_view/presentation/manager/change_credintials_cubit/change_credinitials_cubit.dart';
import 'package:untitled2/features/setting_view/presentation/manager/change_default_cubit/change_cubit.dart';
import 'package:untitled2/features/setting_view/presentation/manager/change_email_cubit/change_email_cubit.dart';
import 'package:untitled2/features/setting_view/presentation/manager/change_password_cubit/change_password_cubit.dart';
import 'package:untitled2/features/setting_view/presentation/views/change_credintials.dart';
import 'package:untitled2/features/setting_view/presentation/views/change_email_view.dart';
import 'package:untitled2/features/setting_view/presentation/views/change_password_view.dart';
import 'package:untitled2/features/setting_view/presentation/views/privacy_setting_view.dart';
import 'package:untitled2/features/transactions/presentation/views/transaction_details.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => RouteGenerator.getScreen(settings.name!),
      settings: settings,
    );
  }

  static Widget getScreen(String route) {
    switch (route) {
      case RoutesNames.splashView:
        return const SplashView();
      case RoutesNames.ManageAccounts:
        return MultiBlocProvider(
          providers: [
            BlocProvider<ManageBankAccountsCubit>(
              create: (context) => ManageBankAccountsCubit(ServiceLocator.getIt<BankRepoImpl>())..fetchUserBanks(),
            ),
            BlocProvider<ForgetPinCubit>(
              create: (context) => ForgetPinCubit(ServiceLocator.getIt<SettingRepoImpl>()),
            ),
            BlocProvider<ChangeDefaultAccCubit>(
              create: (context) => ChangeDefaultAccCubit(ServiceLocator.getIt<SettingRepoImpl>()),
            ),
          ],
          child: const ManageAccounts(),
        );
      case RoutesNames.chooseBank:
        return BlocProvider<BanksCubit>(
          create: (context) => BanksCubit(bankProxy: BankListProxy(ServiceLocator.getIt<SharedPreferences>(), ServiceLocator.getIt<AllBanksRepoImpl>()))..fetchBanks(),
          child: ChooseAccountView(),
        );
      case RoutesNames.adminLayout:
        return BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(),
          child: const AdminLayout(),
        );
      case RoutesNames.pinView:
        return BlocProvider<GetBalanceCubit>(
          create: (context) => GetBalanceCubit(ServiceLocator.getIt<BankRepoImpl>()),
          child: PinCodeScreen(),
        );
      case RoutesNames.layoutView:
        return MultiBlocProvider(
          providers: [
            BlocProvider<TransactionCubit>(
              create: (context) => TransactionCubit(ServiceLocator.getIt<TransactionRepository>()),
            ),
            BlocProvider<NotificationsCubit>(
              create: (context) => NotificationsCubit(NotificationsRepo()),
            ),
            BlocProvider<NavigationCubit>(
              create: (context) => NavigationCubit(),
            )
          ],
          child: const LayoutView(),
        );
      case RoutesNames.loginView:
        return BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(ServiceLocator.getIt<AuthRepoImpl>()),
          child: const LoginView(),
        );
      case RoutesNames.signupView:
        return BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(ServiceLocator.getIt<AuthRepoImpl>()),
          child: const SignupView(),
        );
      case RoutesNames.ForgetPasswordView:
        return BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(ServiceLocator.getIt<AuthRepoImpl>()),
          child: ForgetPasswordView(),
        );
      case RoutesNames.AddBankAccount:
        return BlocProvider<AddAccountCubit>(
          create: (context) => AddAccountCubit(ServiceLocator.getIt<BankRepoImpl>()),
          child: AddBankAccount(),
        );
      case RoutesNames.changeCridintials:
        return BlocProvider<ChangeCredinitialsCubit>(
          create: (context) => ChangeCredinitialsCubit(ServiceLocator.getIt<SettingRepoImpl>()),
          child: ChangeCredintials(),
        );
      case RoutesNames.privacySetting:
        return const PrivacySettingView();
      case RoutesNames.changeEmail:
        return BlocProvider<ChangeEmailCubit>(
          create: (context) => ChangeEmailCubit(ServiceLocator.getIt<SettingRepoImpl>()),
          child: ChangeEmailView(),
        );
      case RoutesNames.allTransaction:
        return MultiBlocProvider(
          providers: [
            BlocProvider<TransactionCubit>(
              create: (context) => TransactionCubit(ServiceLocator.getIt<TransactionRepository>()),
            ),
            BlocProvider(
              create: (context) => NotificationsCubit(ServiceLocator.getIt<NotificationsRepo>()),
            ),
          ],
          child: const AllTransactionView(),
        );
      case RoutesNames.changePassword:
        return BlocProvider<ChangePasswordCubit>(
          create: (context) => ChangePasswordCubit(ServiceLocator.getIt<SettingRepoImpl>()),
          child: ChangePassword(),
        );
      case RoutesNames.notifications:
        return BlocProvider<NotificationsCubit>(
          create: (context) => NotificationsCubit(NotificationsRepo()),
          child: NotificationsView(),
        );
      case RoutesNames.notificationsPin:
        return BlocProvider<NotificationsCubit>(
          create: (context) => NotificationsCubit(NotificationsRepo()),
          child: NotificationPinView(),
        );
      case RoutesNames.pinSendView:
        return BlocProvider<SendCubit>(
          create: (context) => SendCubit(ServiceLocator.getIt.get<TransactionRepoImpl>()),
          child: SendPin(),
        );
      case RoutesNames.EnterPasswordView:
        return BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(AuthRepoImpl()),
          child: EnterPasswordView(),
        );
      case RoutesNames.onBoarding:
        return BlocProvider<OnBoardingCubit>(
          create: (context) => OnBoardingCubit(),
          child: const OnBoardingView(),
        );
      case RoutesNames.transactionDetails:
        return BlocProvider<TransactionCubit>(
          create: (context) => TransactionCubit(ServiceLocator.getIt<TransactionRepository>()),
          child: const TransactionDetailsScreen(),
        );
      case RoutesNames.transactionsSummary:
        return BlocProvider<TransactionSummaryViewCubit>(
          create: (context) => TransactionSummaryViewCubit(ServiceLocator.getIt<GetMonthlyTransactions>(), ServiceLocator.getIt<GetAnnualTransactions>()),
          child: const TransactionsSummaryScreen(),
        );
      case RoutesNames.accountUsageAnalysis:
        return BlocProvider<UsageAnalysisCubit>(
          create: (context) => UsageAnalysisCubit(ServiceLocator.getIt<GetEachUserTransactions>()),
          child: const AccountUsageAnalysisScreen(),
        );
      case RoutesNames.changePin:
        return BlocProvider<ChangePinCubit>(
          create: (context) => ChangePinCubit(ServiceLocator.getIt<BankRepoImpl>()),
          child: ChangePin(),
        );
      case RoutesNames.analyticsView:
        return const AnalyticsView();
      case RoutesNames.forgotPin:
        return BlocProvider<ConfirmForgetPinCubit>(
          create: (context) => ConfirmForgetPinCubit(ServiceLocator.getIt<SettingRepoImpl>()),
          child: ForgetPin(),
        );
      case RoutesNames.changeLimit:
        return BlocProvider<ChangeLimitCubit>(
          create: (context) => ChangeLimitCubit(ServiceLocator.getIt<SettingRepoImpl>()),
          child: const ChangeLimit(),
        );
      case RoutesNames.adminSetting:
        return BlocProvider<LogOutCubit>(
          create: (context) => LogOutCubit(ServiceLocator.getIt.get<SettingRepoImpl>()),
          child: const AdminSetting(),
        );
      case RoutesNames.allUsersView:
        return MultiBlocProvider(
          providers: [
            BlocProvider<AdminGetUsersCubit>(
              create: (context) => AdminGetUsersCubit(ServiceLocator.getIt<AdminRepoImpl>())..getAllUsers(),
            ),
            BlocProvider<BanUsersCubit>(
              create: (context) => BanUsersCubit(ServiceLocator.getIt<AdminRepoImpl>()),
            ),
          ],
          child: AllUsersView(),
        );
      case RoutesNames.homeView:
        return BlocProvider<ForgetPinCubit>(
          create: (context) => ForgetPinCubit(ServiceLocator.getIt.get<SettingRepoImpl>()),
          child: HomeView(),
        );
      case RoutesNames.sendMoneyView:
        return SendMoneyView();
      case RoutesNames.receiveMoneyView:
        return BlocProvider<ReceiveCubit>(
          create: (context) => ReceiveCubit(ServiceLocator.getIt.get<TransactionRepoImpl>()),
          child: ReceiveMoneyView(),
        );
      case RoutesNames.settingView:
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LogOutCubit(ServiceLocator.getIt.get<SettingRepoImpl>()),
            ),
            BlocProvider(
              create: (context) => ForgetPinCubit(ServiceLocator.getIt.get<SettingRepoImpl>()),
            )
          ],
          child: SettingView(),
        );
      default:
        return const SplashView();
    }
  }
}
