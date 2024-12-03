import 'package:flutter/material.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/features/auth/presentation/views/forget_password_view.dart';
import 'package:untitled2/features/auth/presentation/views/login_view.dart';
import 'package:untitled2/features/auth/presentation/views/otp_view.dart';
import 'package:untitled2/features/auth/presentation/views/signup_view.dart';
import 'package:untitled2/features/setting_view/presentation/views/change_credintials.dart';
import 'package:untitled2/features/setting_view/presentation/views/change_email_view.dart';
import 'package:untitled2/features/setting_view/presentation/views/change_password_view.dart';
import 'package:untitled2/features/setting_view/presentation/views/privacy_setting_view.dart';

import '../../features/account_managment/presentation/add_account_view.dart';
import '../../features/layout_view/presentation/views/layout_view.dart';
import '../../features/splash_view/presentation/views/splash_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.splashView:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
          settings: settings,
        );
      case RoutesNames.AddAccountView:
        return MaterialPageRoute(
          builder: (context) => const AddAccountView(),
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
      case RoutesNames.changeCridintials:
        return MaterialPageRoute(
          builder: (context) => ChangeCredintials(),
          settings: settings,
        );
      case RoutesNames.privacySetting:
        return MaterialPageRoute(
          builder: (context) => PrivacySettingView(),
          settings: settings,
        );
      case RoutesNames.changeEmail:
        return MaterialPageRoute(
          builder: (context) =>  ChangeEmailView(),
          settings: settings,
        );
      case RoutesNames.changePassword:
        return MaterialPageRoute(
          builder: (context) => const ChangePassword(),
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
