import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

import 'package:givt_mobile_apps/core/constants/routes.dart';
import 'package:givt_mobile_apps/core/models/realm_model.dart';
import 'features/benefits/usp.dart';
import 'core/themes/primary_theme.dart';
import './features/benefits/usp.dart';
import './core/constants/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Realm realm;

  _MyAppState() {
    final config =
        Configuration.local([OnboardingProgress.schema, OnboardedUser.schema]);
    realm = Realm(config);
  }

  @override
  void initState() {
    if (realm.all<OnboardingProgress>().isEmpty) {
      var progressTrack = OnboardingProgress(
        locationAsked: false,
        cameraAsked: false,
        emailRegistered: false,
      );
      realm.write(() => realm.add(progressTrack));
    }
    super.initState();
  }

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
