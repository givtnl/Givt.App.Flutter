import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/features/presentation/pages/location_permission_page.dart';

import 'features/presentation/pages/home_page.dart';
import 'features/presentation/pages/usp.dart';

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
    );
  }
}
