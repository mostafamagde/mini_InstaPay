import 'package:flutter/material.dart';

import 'core/app_theme/app_theme_manager.dart';
import 'core/routes_manager/route_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mini InstaPay",
      onGenerateRoute: RouteGenerator.generateRoutes,
      debugShowCheckedModeBanner: false,
      theme: AppThemeManager.mainTheme,
    );
  }
}
