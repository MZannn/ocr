import 'package:flutter/material.dart';
import 'package:ocr_visitor/view/form_view.dart';
import 'package:ocr_visitor/view/login_view.dart';

import '../cubit/camera/camera_cubit.dart';

class Routes {
  Route route(RouteSettings settings) {
    switch (settings.name) {
      // case '/':
      //   return MaterialPageRoute(
      //     builder: (context) => const LoginView(),
      //   );
      case '/':
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => CameraCubit(),
            child: const FormView(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(),
        );
    }
  }
}
