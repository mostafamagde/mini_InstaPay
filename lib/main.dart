import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mini_instapay/core/utils/service_locator.dart';
import 'package:mini_instapay/features/otp/presentation/manger/cubit/otp_cubit.dart';
import 'core/app_theme/app_theme_manager.dart';
import 'core/routes_manager/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServiceLocator.setup();

  runApp(
    DevicePreview(
      enabled: false,
      tools: const [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return BlocProvider<OtpCubit>(
          create: (context) => OtpCubit(),
          child: MaterialApp(
            title: "Mini InsatPay",
            onGenerateRoute: RouteGenerator.generateRoutes,
            debugShowCheckedModeBanner: false,
            theme: AppThemeManager.mainTheme,
          ),
        );
      },
    );
  }
}
