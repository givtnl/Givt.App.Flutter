import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/pages/amount_input.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/pages/amount_typical.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/pages/donation_success.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/pages/donation.dart';
import 'package:givt_mobile_apps/features/home_screen/pages/first_giving_options.dart';
import 'package:givt_mobile_apps/features/home_screen/pages/first_use.dart';
import 'package:givt_mobile_apps/features/home_screen/pages/home_screen.dart';
import 'package:givt_mobile_apps/features/startup/pages/startup.dart';
import 'package:givt_mobile_apps/features/user_identity_creation/page/login.dart';
import 'package:givt_mobile_apps/features/user_identity_creation/page/sign_up.dart';
import '../core/constants/route_paths.dart' as routes;
import '../features/basic_giving_flow/pages/qr_scanner.dart';
import '../features/permissions/pages/camera_permission.dart';
import '../features/permissions/pages/location_permission.dart';
import '../features/registration/pages/registration.dart';
import '../features/archived/pages/old_login_usp.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.StartupRoute:
      return MaterialPageRoute(builder: (context) => const StartupPage());
    case routes.LoginRoute:
      final String? email = settings.arguments as String?;
      return MaterialPageRoute(
          builder: (context) => LoginPage(passedEmail: email));
    case routes.CameraPermissionRoute:
      return MaterialPageRoute(
          builder: (context) => const CameraPermissionPage());
    case routes.LocationPermissionRoute:
      return MaterialPageRoute(
          builder: (context) => const LocationPermissionPage());
    case routes.RegistrationRoute:
      return MaterialPageRoute(
          builder: (context) => const FirstTimeRegistrationPage());
    case routes.QRScannerPage:
      return MaterialPageRoute(builder: (context) => QRScannerPage());
    case routes.DonationAmountTypicalRoute:
      return MaterialPageRoute(builder: (context) => DoantionAmountTypical());
    case routes.DonationAmountInputRoute:
      return MaterialPageRoute(builder: (context) => DonationAmountInput());
    case routes.DonationSuccessRoute:
      return MaterialPageRoute(builder: (context) => SuccessDonationPage());
    case routes.WepayRoute:
      return MaterialPageRoute(builder: ((context) => const DonationPage()));
    case routes.HomeScreenRoute:
      return MaterialPageRoute(builder: (context) => HomeScreenPage());
    case routes.FirstUseScreenRoute:
      return MaterialPageRoute(builder: (context) => FirstUsePage());
    case routes.FirstOptionsRoute:
      return MaterialPageRoute(builder: (context) => FirstOptionsPage());
    case routes.SignUpRoute:
      return MaterialPageRoute(builder: (context) => SignUpPage());
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
