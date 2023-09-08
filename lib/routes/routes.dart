import 'package:flutter/material.dart';
import 'package:ocr_visitor/cubit/login/login_cubit.dart';
import 'package:ocr_visitor/cubit/navigation/navigation_cubit.dart';
import 'package:ocr_visitor/view/login_view.dart';
import 'package:ocr_visitor/view/navigation_view.dart';

import '../cubit/camera/camera_cubit.dart';

class Routes {
  Route route(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginCubit(),
            child: const LoginView(),
          ),
        );
      case '/navigation':
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(providers: [
            BlocProvider(
              create: (context) => NavigationCubit()..changeScreen(0),
            ),
            BlocProvider(
              create: (context) => CameraCubit(),
            ),
          ], child: const NavigationView()),
        );
      // case '/form':
      //   return MaterialPageRoute(
      //     builder: (context) => BlocProvider(
      //       create: (context) => CameraCubit(),
      //       child: const FormView(),
      //     ),
      //   );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(),
        );
    }
  }
}
