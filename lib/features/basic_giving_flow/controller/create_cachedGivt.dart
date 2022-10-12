import 'dart:io';
import 'package:givt_mobile_apps/models/localStorage.dart';

import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

void createCachedGivtandNavigate(int donationAmount, String mediumId) {
  DateTime dateTime = DateTime.now();

  final NavigationService navigationService = locator<NavigationService>();
  final LocalStorageProxy model = locator<LocalStorageProxy>();

// fourth arg is null bc the current flow doesnt register the email so it does not fetch the userId
  model.createCachedGivt(mediumId, donationAmount, dateTime, null);

// check for connection before this navigation
  if (Platform.isIOS) {
    // this should direct to ifram in the inapp browser bc of apple store policies
    navigationService.navigateTo(routes.DonationSuccessRoute);
  }
// this should direct to iframe in the app
  navigationService.navigateTo(routes.DonationSuccessRoute);
}
