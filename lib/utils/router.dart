import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/pages/amount_input.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/pages/amount_typical.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/pages/donation_success.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/pages/doantion_wepay_iframe.dart';
import 'package:givt_mobile_apps/features/home_screen/pages/first_use.dart';
import 'package:givt_mobile_apps/features/home_screen/pages/home_screen.dart';
import 'package:givt_mobile_apps/features/startup/pages/startup_page.dart';
import 'package:givt_mobile_apps/features/user_identity_creation/page/login.dart';
import 'package:givt_mobile_apps/features/user_identity_creation/page/sign_up.dart';
import '../core/constants/route_paths.dart' as routes;
import '../features/basic_giving_flow/pages/qr_mock.dart';
import '../features/benefits/usp.dart';
import '../features/permissions/pages/camera_permission_page.dart';
import '../features/permissions/pages/location_permission_page.dart';
import '../features/registration/pages/first_time_registration_page.dart';
import '../features/archived/pages/old_login_usp.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
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
    case routes.FirstUseScreenRoute:
      return MaterialPageRoute(builder: (context) => FirstUsePage());
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
