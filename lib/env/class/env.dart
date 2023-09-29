import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ocr_visitor/env/variable/constant.dart';
import 'package:ocr_visitor/src/form_visitor/state/form_cubit.dart';
import 'package:ocr_visitor/src/history/state/history_cubit.dart';
import 'package:ocr_visitor/src/login/state/auth_cubit.dart';
import 'package:ocr_visitor/src/login/widget/login_view.dart';
import 'package:ocr_visitor/src/navigation/state/navigation_cubit.dart';
import 'package:ocr_visitor/src/navigation/widget/navigation_view.dart';
import 'package:ocr_visitor/src/profile/state/profile_cubit.dart';
import 'package:ocr_visitor/src/splash/widget/splash_view.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'routes.dart';
part '../models/report_model.dart';
part '../enum/enum.dart';
part 'asset.dart';
part 'api.dart';

typedef Env = Environment;

class Environment {
  static Map<String, Widget Function(BuildContext)> routes = {
    for (Routes route in [
      Routes.splash,
      Routes.login,
      Routes.homepage,
    ])
      route.path: (BuildContext context) => route.page,
  };
  static String initialRoute = Routes.splash.path;
}
