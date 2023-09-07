import 'package:flutter/material.dart';
import 'package:ocr_visitor/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => Routes().route(settings),
    );
  }
}
