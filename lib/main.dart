import 'package:flutter/material.dart';
import 'package:platzi_app/locator.dart';
import 'package:platzi_app/route/router.dart';
import 'package:platzi_app/theme/theme.dart';
import 'package:starlight_utils/starlight_utils.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await setUp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: StarlightUtils.navigatorKey,
      title: 'Flutter Demo',
      theme: LightTheme().theme,
      onGenerateRoute: router,
    );
  }
}
