import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:givt_mobile_apps/core/constants/routes.dart';
import 'features/benefits/usp.dart';
import 'core/themes/primary_theme.dart';
import 'core/models/progress.dart';
import 'core/controllers/camera_permission_controller.dart';
import 'core/controllers/location_permission_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final CameraController _cameraController;
  late final LocationController _locationController;
  @override
  void initState() {
    _cameraController = CameraController();
    _locationController = LocationController();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    await _cameraController.determineStatus();
    await _locationController.determineStatus();
  }

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
