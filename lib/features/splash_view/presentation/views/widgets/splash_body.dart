import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mini_instapay/core/api_helper/api_constants.dart';
import 'package:mini_instapay/core/api_helper/api_manger.dart';
import 'package:mini_instapay/core/enums/role_enum.dart';
import 'package:mini_instapay/core/models/user_model.dart';
import 'package:mini_instapay/core/routes_manager/routes_names.dart';
import 'package:mini_instapay/core/utils/socket_service.dart';
import 'AnimatedBuilder.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    navigatingToHome();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Container(
        color: theme.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              "assets/images/InstaSplash.png",
            ),
            const SizedBox(
              height: 20,
            ),
            SlideTransition(
              position: slidingAnimation,
              child: AnimationBuilder(slidingAnimation: slidingAnimation),
            )
          ],
        ),
      ),
    );
  }

  void navigatingToHome() {
    Future.delayed(const Duration(seconds: 3), () async {
      final storage = new FlutterSecureStorage();
      try {
        final token = await storage.read(key: "token");
        if (token != null && token.isNotEmpty) {
          UserModel.instance.token = token;
          final apiManager = ApiManager();
          final userDataResponse = await apiManager.get(
            ApiConstants.getUserData,
            headers: {
              "token": token,
            },
          );
          UserModel.instance.setFromjson(userDataResponse.data["data"]);
          SocketService.instance.connect();
          Navigator.pushReplacementNamed(
            context,
            UserModel.instance.role == Role.Admin ? RoutesNames.adminLayout : RoutesNames.layoutView,
          );
        } else {
          Navigator.pushReplacementNamed(
            context,
            RoutesNames.onBoarding,
          );
        }
      } catch (e) {
        Navigator.pushReplacementNamed(
          context,
          RoutesNames.onBoarding,
        );
      }
    });
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    slidingAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: const Offset(0, -2),
    ).animate(animationController);
    animationController.forward();
  }
}
