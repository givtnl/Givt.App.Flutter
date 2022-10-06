import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/pages/donation_amount.dart';
import 'package:givt_mobile_apps/features/startup/pages/startup_page.dart';
import '../core/constants/route_paths.dart' as routes;
import '../features/basic_giving_flow/pages/qr_mock_page.dart';
import '../features/benefits/usp.dart';
import '../features/permissions/pages/camera_permission_page.dart';
import '../features/permissions/pages/location_permission_page.dart';
import '../features/registration/pages/first_time_registration_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  print(settings.name);
  switch (settings.name) {
    case routes.StartupRoute:
      return MaterialPageRoute(builder: (context) => const StartupPage());
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
    case routes.QRMockRoute:
      return MaterialPageRoute(builder: (context) => QRmockPage());
    case routes.DonationAmountRoute:
      return MaterialPageRoute(builder: (context) => DoantionAmount());
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
