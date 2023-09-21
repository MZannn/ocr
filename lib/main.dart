import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ocr_visitor/env/class/env.dart';

Future<void> main() async {
  initializeDateFormatting('id_ID', null);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'OCR Visitor',
      theme: ThemeData(
        useMaterial3: true,
      ),
      routes: Env.routes,
      initialRoute: Env.initialRoute,
    ),
  );
}

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return;
//   }
// }
