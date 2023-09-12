import 'package:flutter/material.dart';
import 'package:ocr_visitor/cubit/auth/auth_cubit.dart';
import 'package:ocr_visitor/cubit/history/history_cubit.dart';
import 'package:ocr_visitor/cubit/navigation/navigation_cubit.dart';
import 'package:ocr_visitor/view/login_view.dart';
import 'package:ocr_visitor/view/navigation_view.dart';

import '../cubit/form/form_cubit.dart';

class Routes {
  Route route(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit()..checkToken(),
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
              create: (context) => FormCubit()..getResidentData(),
            ),
            BlocProvider(
              create: (context) => AuthCubit(),
            ),
            BlocProvider(
              create: (context) => HistoryCubit()..getAllHistories(),
            ),
          ], child: const NavigationView()),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(),
        );
    }
  }
}
