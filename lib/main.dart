import 'dart:developer';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled2/core/utils/service_locator.dart';
import 'package:untitled2/core/utils/socket_service.dart';
import 'package:untitled2/features/otp/presentation/manger/cubit/otp_cubit.dart';
import 'core/app_theme/app_theme_manager.dart';
import 'core/routes_manager/route_generator.dart';

void main() {
  ServiceLocator.setup();

  runApp(
    DevicePreview(
      enabled: true,
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
          return BlocProvider(
            create: (context) => OtpCubit(),
            child: MaterialApp(
              title: "Mini InsatPay",
              onGenerateRoute: RouteGenerator.generateRoutes,
              debugShowCheckedModeBanner: false,
              theme: AppThemeManager.mainTheme,
            ),
          );
        });
  }
}

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final _socketService = SocketService.instance;

//   @override
//   void initState() {
//     super.initState();
//     _socketService.connect();
//   }

//   @override
//   void dispose() {
//     _socketService.disconnect();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Socket.IO Example')),
//         body: Column(
//           children: [
//             Expanded(
//               child: StreamBuilder<String>(
//                 stream: _socketService.stream,
//                 builder: (context, snapshot) {
//                   log(snapshot.connectionState.toString());
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else if (!snapshot.hasData) {
//                     return Center(child: Text('No data received yet'));
//                   } else {
//                     return Center(child: Text('Message: ${snapshot.data}'));
//                   }
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 onSubmitted: (message) {
//                   _socketService.sendMessage(message);
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Send a message',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
