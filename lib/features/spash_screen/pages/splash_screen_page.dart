import 'package:flutter/material.dart';
import 'dart:async';
import '../../../core/templates/logo_header_template.dart';
import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

class SplashScreenPage extends StatelessWidget {
  NavigationService _navigationService = locator<NavigationService>();
  SplashScreenPage({super.key});

  void _startTimer() {
    Timer(const Duration(seconds: 2), () {
      _navigationService.navigateTo(routes.StartupRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    _startTimer();
    return const Scaffold(
      body: Center(
        child: LogoHeaderTemplate(),
      ),
    );
  }
}
