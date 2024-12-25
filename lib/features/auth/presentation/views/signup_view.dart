import 'package:flutter/material.dart';
import 'package:untitled2/features/auth/presentation/views/widgets/signup_body.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SignupBody(),
    );
  }
}
