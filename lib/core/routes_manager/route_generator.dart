import 'package:flutter/material.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';

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

      case RoutesNames.layoutView:
        return MaterialPageRoute(
          builder: (context) => const LayoutView(),
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
