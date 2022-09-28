import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:givt_mobile_apps/core/constants/routes.dart';
import 'features/benefits/usp.dart';
import 'core/themes/primary_theme.dart';
import 'models/progress.dart';
import 'providers/camera_permission.dart';
import 'providers/location_permission.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => OnboardingProgressModel()),
      ],
      child: MaterialApp(
        title: 'Givt',
        debugShowCheckedModeBanner: false,
        theme: PrimaryTheme.theme,
        home: const UspPage(),
        routes: routes,
      ),
    );
  }
}
