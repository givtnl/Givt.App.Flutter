import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/features/startup/pages/startup_page.dart';
import '../core/constants/route_paths.dart' as routes;
import '../features/benefits/usp.dart';
import '../features/permissions/pages/camera_permission_page.dart';
import '../features/permissions/pages/location_permission_page.dart';
import '../features/registration/pages/first_time_registration_page.dart';
import '../features/login/pages/login_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  print(settings.name);
  switch (settings.name) {
    case routes.StartupRoute:
      return MaterialPageRoute(builder: (context) => const StartupPage());
    case routes.LoginRoute:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case routes.UspRoute:
      return MaterialPageRoute(builder: (context) => const UspPage());
    case routes.CameraPermissionRoute:
      return MaterialPageRoute(
          builder: (context) => const CameraPermissionPage());
    case routes.LocationPermissionRoute:
      return MaterialPageRoute(
          builder: (context) => const LocationPermissionPage());
    case routes.RegistrationRoute:
      return MaterialPageRoute(
          builder: (context) => const FirstTimeRegistrationPage());
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
