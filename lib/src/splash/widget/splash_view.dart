import 'package:flutter/material.dart';
import 'package:ocr_visitor/env/class/env.dart';
import 'package:ocr_visitor/env/extension/on_context.dart';
import 'package:ocr_visitor/src/login/state/auth_cubit.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Future.delayed(
              const Duration(seconds: 2),
              () {
                context.toRemoveNamed(
                  route: Routes.homepage.path,
                );
              },
            );
          }
          if (state is LoginFailed) {
            Future.delayed(
              const Duration(seconds: 2),
              () {
                context.toRemoveNamed(
                  route: Routes.login.path,
                );
              },
            );
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Image.asset("assets/images/logo.png"),
          ),
        ),
      ),
    );
  }
}
