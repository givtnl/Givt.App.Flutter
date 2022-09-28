import 'package:flutter/material.dart';
import 'core/themes/primary_theme.dart';
import './features/benefits/usp.dart';
import './core/constants/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Givt',
      debugShowCheckedModeBanner: false,
      theme: PrimaryTheme.theme,
      home: const UspPage(),
      routes: routes,
    );
  }
}
