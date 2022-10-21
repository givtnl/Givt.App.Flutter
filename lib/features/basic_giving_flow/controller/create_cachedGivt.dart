import 'dart:io';
import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/models/localStorage.dart';
import 'package:givt_mobile_apps/utils/connection_check.dart';

import '../../../core/widgets/notifications/snackbar.dart';
import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

Future<void> createCachedGivtandNavigate(
    int donationAmount, String mediumId) async {
  bool connected = await tryConnection();
  DateTime dateTime = DateTime.now();

  final NavigationService navigationService = locator<NavigationService>();
  final LocalStorageProxy model = locator<LocalStorageProxy>();

// fourth arg is null bc the current flow doesnt register the email so it does not fetch the userId
  //model.createCachedGivt(mediumId, donationAmount, dateTime, null);

  if (connected && Platform.isIOS) {
    // this should direct to ifram in the inapp browser bc of apple store policies
    navigationService.navigateTo(routes.WepayRoute);
  } else if (connected) {
// this should direct to iframe in the app
    navigationService.navigateTo(routes.WepayRoute);
  } else {
    // sorry you cannot make a donnation while offline
    print('you are offline');
    // SnackBarNotifyer(ctx).showSnackBarMessage('You are not connected to the internet', Colors.red);
  }
}