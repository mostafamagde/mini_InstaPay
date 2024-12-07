import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/service_locator.dart';
import 'package:untitled2/features/auth/presentation/views/forget_password_view.dart';
import 'package:untitled2/features/auth/presentation/views/login_view.dart';
import 'package:untitled2/features/auth/presentation/views/signup_view.dart';
import 'package:untitled2/features/setting_view/presentation/manager/change_email_cubit/change_email_cubit.dart';
import 'package:untitled2/features/setting_view/presentation/manager/change_password_cubit/change_password_cubit.dart';
import 'package:untitled2/features/setting_view/presentation/views/change_credintials.dart';
import 'package:untitled2/features/setting_view/presentation/views/change_email_view.dart';
import 'package:untitled2/features/setting_view/presentation/views/change_password_view.dart';
import 'package:untitled2/features/setting_view/presentation/views/privacy_setting_view.dart';

import '../../features/account_managment/data/repos/bank_repo_impl.dart';
import '../../features/account_managment/presentation/manager/get_all_user_bank_accounts/manage_bank_accounts_cubit.dart';
import '../../features/account_managment/presentation/views/add_bank_account.dart';
import '../../features/account_managment/presentation/views/choose_bank_account_view.dart';
import '../../features/account_managment/presentation/views/manage_accounts.dart';
import '../../features/layout_view/presentation/views/layout_view.dart';
import '../../features/setting_view/data/repos/setting_repo_impl.dart';
import '../../features/setting_view/presentation/manager/change_credintials_cubit/change_credinitials_cubit.dart';
import '../../features/splash_view/presentation/views/splash_view.dart';

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
              BlocProvider(
                create: (context) => ManageBankAccountsCubit(
                    ServiceLocator.getIt<BankRepoImpl>())
                  ..fetchUserBanks(),
              ),

            ],
            child: ManageAccounts(),
          ),
          settings: settings,
        );
      case RoutesNames.chooseBank:
        return MaterialPageRoute(
          builder: (context) => const ChooseAccountView(),
          settings: settings,
        );

      case RoutesNames.layoutView:
        return MaterialPageRoute(
          builder: (context) => const LayoutView(),
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
          builder: (context) => AddBankAccount(),
          settings: settings,
        );
      case RoutesNames.changeCridintials:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ChangeCredinitialsCubit(
                ServiceLocator.getIt<SettingRepoImpl>()),
            child: ChangeCredintials(),
          ),
          settings: settings,
        );
      case RoutesNames.privacySetting:
        return MaterialPageRoute(
          builder: (context) => PrivacySettingView(),
          settings: settings,
        );
      case RoutesNames.changeEmail:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                ChangeEmailCubit(ServiceLocator.getIt<SettingRepoImpl>()),
            child: ChangeEmailView(),
          ),
          settings: settings,
        );
      case RoutesNames.changePassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                ChangePasswordCubit(ServiceLocator.getIt<SettingRepoImpl>()),
            child: ChangePassword(),
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
