import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/constants/routes.dart';

import 'features/benefits/usp.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Mulish',
      ),
      home: const UspPage(),
      routes: routes,
    );
  }
}
