import 'package:flutter/material.dart';
import 'package:untitled2/features/auth/data/repository/auth_repo_impl.dart';
import 'package:untitled2/features/auth/presentation/views/widgets/login_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/features/auth/presentation/manger/auth_cubit/auth_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(AuthRepoImpl()),
      child: const Scaffold(
        body: LoginBody(),
      ),
    );
  }
}