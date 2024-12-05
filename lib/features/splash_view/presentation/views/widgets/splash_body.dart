

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:untitled2/core/models/user_model.dart';

import '../../../../../core/routes_manager/routes_names.dart';
import 'AnimatedBuilder.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin {
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
    var theme = Theme.of(context);
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
    Future.delayed(
      const Duration(seconds: 3),
      ()  async{
        final storage = new FlutterSecureStorage();
        try{
       final token= await storage.read(key: "token");
       print(token);
       if (token!=null){

        UserModel.getInstance().token=token;
               Navigator.pushReplacementNamed(context,
        RoutesNames.layoutView,);
       }
    else{  Navigator.pushReplacementNamed(context,
        RoutesNames.loginView,);}
        } catch (e) {
          print("sssssssss");
          print(e.toString());
          Navigator.pushReplacementNamed(context,
        RoutesNames.loginView,);
        }
        }
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    slidingAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: const Offset(0,-2),
    ).animate(animationController);
    animationController.forward();
  }
}
