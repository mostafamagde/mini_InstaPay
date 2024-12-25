import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/navigation_cubit/navigation_cubit.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/service_locator.dart';
import 'package:untitled2/features/account_managment/data/repos/bank_repo_impl.dart';
import 'package:untitled2/features/account_managment/presentation/manager/add_account/add_account_cubit.dart';
import 'package:untitled2/features/account_managment/presentation/manager/balance_cubit/get_balance_cubit.dart';
import 'package:untitled2/features/account_managment/presentation/manager/change_pin_cubit/change_pin_cubit.dart';
import 'package:untitled2/features/account_managment/presentation/manager/manage_user_bank_accounts/manage_bank_accounts_cubit.dart';
import 'package:untitled2/features/account_managment/presentation/views/add_bank_account.dart';
import 'package:untitled2/features/account_managment/presentation/views/change_pin_view.dart';
import 'package:untitled2/features/account_managment/presentation/views/choose_bank_account_view.dart';
import 'package:untitled2/features/account_managment/presentation/views/manage_accounts.dart';
import 'package:untitled2/features/account_managment/presentation/views/pin_view.dart';
import 'package:untitled2/features/admn/presentation/views/admin_layout.dart';
import 'package:untitled2/features/auth/data/repository/auth_repo_impl.dart';
import 'package:untitled2/features/auth/presentation/manger/auth_cubit/auth_cubit.dart';
import 'package:untitled2/features/auth/presentation/views/enter_password_view.dart';
import 'package:untitled2/features/auth/presentation/views/forget_password_view.dart';
import 'package:untitled2/features/auth/presentation/views/login_view.dart';
import 'package:untitled2/features/auth/presentation/views/signup_view.dart';
import 'package:untitled2/features/reports/domain/use_cases/get_annual_transactions.dart';
import 'package:untitled2/features/reports/domain/use_cases/get_each_user_transactions.dart';
import 'package:untitled2/features/reports/domain/use_cases/get_monthly_transactions.dart';
import 'package:untitled2/features/reports/presentation/manager/transaction_summary_view_cubit/transaction_summary_view_cubit.dart';
import 'package:untitled2/features/reports/presentation/manager/usage_analysis_cubit/usage_analysis_cubit.dart';
import 'package:untitled2/features/reports/presentation/views/account_usage_analysis_screen.dart';
import 'package:untitled2/features/reports/presentation/views/analytics_view.dart';
import 'package:untitled2/features/reports/presentation/views/transactions_summary_screen.dart';
import 'package:untitled2/features/setting_view/presentation/manager/change_limit/change_limit_cubit.dart';
import 'package:untitled2/features/setting_view/presentation/views/change_limit.dart';
import 'package:untitled2/features/splash_view/presentation/views/splash_view.dart';
import 'package:untitled2/features/transaction_module/data/repos/transaction_repo_impl.dart';
import 'package:untitled2/features/transaction_module/presentation/manager/send_cubit/send_cubit.dart';
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

import '../../features/setting_view/presentation/manager/confirm_forget_pin/cinfirm_forget_pin_cubit.dart';
import '../../features/setting_view/presentation/manager/forget_pin_cubit/forget_pin_cubit.dart';
import '../../features/setting_view/presentation/views/forget_pin.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.splashView:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
          settings: settings,
        );
      case RoutesNames.ManageAccounts:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<ManageBankAccountsCubit>(
                create: (context) => ManageBankAccountsCubit(ServiceLocator.getIt<BankRepoImpl>())..fetchUserBanks(),
              ),
              BlocProvider(
                create: (context) =>
                    ForgetPinCubit(ServiceLocator.getIt<SettingRepoImpl>()),
              ),
              BlocProvider(
                create: (context) => ChangeDefaultAccCubit(
                    ServiceLocator.getIt<SettingRepoImpl>()),
              ),
            ],
            child: const ManageAccounts(),
          ),
          settings: settings,
        );
      case RoutesNames.chooseBank:
        return MaterialPageRoute(
          builder: (context) => const ChooseAccountView(),
          settings: settings,
        );
      case RoutesNames.adminLayout:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<NavigationCubit>(
            create: (context) => NavigationCubit(),
            child: const AdminLayout(),
          ),
          settings: settings,
        );
      case RoutesNames.pinView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<GetBalanceCubit>(
            create: (context) => GetBalanceCubit(ServiceLocator.getIt<BankRepoImpl>()),
            child: PinCodeScreen(),
          ),
          settings: settings,
        );

      case RoutesNames.layoutView:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
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
          ),
          settings: settings,
        );
      case RoutesNames.loginView:
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
          settings: settings,
        );
      case RoutesNames.signupView:
        return MaterialPageRoute(
          builder: (context) => const SignupView(),
          settings: settings,
        );
      case RoutesNames.ForgetPasswordView:
        return MaterialPageRoute(
          builder: (context) => const ForgetPasswordView(),
          settings: settings,
        );
      case RoutesNames.AddBankAccount:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AddAccountCubit>(
            create: (context) => AddAccountCubit(ServiceLocator.getIt<BankRepoImpl>()),
            child: AddBankAccount(),
          ),
          settings: settings,
        );

      case RoutesNames.changeCridintials:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ChangeCredinitialsCubit>(
            create: (context) => ChangeCredinitialsCubit(ServiceLocator.getIt<SettingRepoImpl>()),
            child: ChangeCredintials(),
          ),
          settings: settings,
        );
      case RoutesNames.privacySetting:
        return MaterialPageRoute(
          builder: (context) => const PrivacySettingView(),
          settings: settings,
        );
      case RoutesNames.changeEmail:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ChangeEmailCubit>(
            create: (context) => ChangeEmailCubit(ServiceLocator.getIt<SettingRepoImpl>()),
            child: ChangeEmailView(),
          ),
          settings: settings,
        );
      case RoutesNames.allTransaction:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<TransactionCubit>(
            create: (context) => TransactionCubit(ServiceLocator.getIt<TransactionRepository>()),
            child: const AllTransactionView(),
          ),
          settings: settings,
        );
      case RoutesNames.changePassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ChangePasswordCubit>(
            create: (context) => ChangePasswordCubit(ServiceLocator.getIt<SettingRepoImpl>()),
            child: ChangePassword(),
          ),
          settings: settings,
        );
      case RoutesNames.notifications:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<NotificationsCubit>(
            create: (context) => NotificationsCubit(NotificationsRepo()),
            child: NotificationsView(),
          ),
          settings: settings,
        );
      case RoutesNames.notificationsPin:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<NotificationsCubit>(
            create: (context) => NotificationsCubit(NotificationsRepo()),
            child: NotificationPinView(),
          ),
          settings: settings,
        );
      case RoutesNames.pinSendView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<SendCubit>(
            create: (context) => SendCubit(ServiceLocator.getIt.get<TransactionRepoImpl>()),
            child: SendPin(),
          ),
          settings: settings,
        );
      case RoutesNames.EnterPasswordView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(AuthRepoImpl()),
            child: EnterPasswordView(),
          ),
          settings: settings,
        );
      case RoutesNames.onBoarding:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<OnBoardingCubit>(
            create: (context) => OnBoardingCubit(),
            child: const OnBoardingView(),
          ),
          settings: settings,
        );
      case RoutesNames.transactionDetails:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<TransactionCubit>(
            create: (context) => TransactionCubit(ServiceLocator.getIt<TransactionRepository>()),
            child: const TransactionDetailsScreen(),
          ),
          settings: settings,
        );
      case RoutesNames.transactionsSummary:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<TransactionSummaryViewCubit>(
            create: (context) => TransactionSummaryViewCubit(ServiceLocator.getIt<GetMonthlyTransactions>(), ServiceLocator.getIt<GetAnnualTransactions>()),
            child: const TransactionsSummaryScreen(),
          ),
          settings: settings,
        );
      case RoutesNames.accountUsageAnalysis:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<UsageAnalysisCubit>(
            create: (context) => UsageAnalysisCubit(ServiceLocator.getIt<GetEachUserTransactions>()),
            child: const AccountUsageAnalysisScreen(),
          ),
          settings: settings,
        );
      case RoutesNames.changePin:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ChangePinCubit>(
            create: (context) => ChangePinCubit(ServiceLocator.getIt<BankRepoImpl>()),
            child: ChangePin(),
          ),
          settings: settings,
        );
      case RoutesNames.analyticsView:
        return MaterialPageRoute(
          builder: (context) => const AnalyticsView(),
          settings: settings,
        );
      case RoutesNames.forgotPin:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                CinfirmForgetPinCubit(ServiceLocator.getIt<SettingRepoImpl>()),
            child: ForgetPin(),
          ),
          settings: settings,
        );
      case RoutesNames.changeLimit:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ChangeLimitCubit(ServiceLocator.getIt<SettingRepoImpl>()),
            child: const ChangeLimit(),
          ),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
          settings: settings,
        );
    }
  }
}
