import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'dart:async';
import '../../startup/pages/startup_page.dart';
import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

class SplashScreenPage extends StatelessWidget {
  NavigationService _navigationService = locator<NavigationService>();
  SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      image: Image.asset('assets/images/logo.png'),
      backgroundColor: Colors.white,
      photoSize: 200.0,
      loaderColor: Theme.of(context).colorScheme.secondary,
      navigateAfterSeconds: const StartupPage(),
    );
  }
}