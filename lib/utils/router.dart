import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/pages/input_amount_page.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/pages/typical_amount_page.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/pages/success_donation.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/pages/wepay_iframe_page.dart';
import 'package:givt_mobile_apps/features/home_screen/home_screen_page.dart';
import 'package:givt_mobile_apps/features/startup/pages/startup_page.dart';
import 'package:givt_mobile_apps/features/user_identity_creation/sign_up_page.dart';
import '../core/constants/route_paths.dart' as routes;
import '../features/basic_giving_flow/pages/qr_mock_page.dart';
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
    case routes.QRMockRoute:
      return MaterialPageRoute(builder: (context) => QRmockPage());
    case routes.DonationAmountTypicalRoute:
      return MaterialPageRoute(builder: (context) => DoantionAmountTypical());
    case routes.DonationAmountInputRoute:
      return MaterialPageRoute(builder: (context) => DoantionAmountInput());
    case routes.DonationSuccessRoute:
      return MaterialPageRoute(builder: (context) => SuccessDonationPage());
    case routes.WepayRoute:
      return MaterialPageRoute(builder: ((context) => const WePayPage()));
    case routes.HomeScreenRoute:
      return MaterialPageRoute(builder: (context) => HomeScreenPage());
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
