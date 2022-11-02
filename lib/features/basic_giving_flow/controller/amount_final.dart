import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/widgets/notifications/snackbar.dart';
import 'package:givt_mobile_apps/services/user_service.dart';
import 'package:givt_mobile_apps/models/localStorage.dart';
import 'package:givt_mobile_apps/utils/connection_check.dart';

import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

class AmountController {
  Future<void> createCachedGivtandNavigate(context, int donationAmount,
      String mediumId, Function toggleLoader) async {
    bool connected = await tryConnection();
    String dateTime = DateTime.now().toIso8601String();
    final UserService usrService = locator<UserService>();

    final NavigationService navigationService = locator<NavigationService>();
    late final LocalStorageProxy realmProxy = locator<LocalStorageProxy>();
    toggleLoader(true);

    if (connected) {
      try {
        //create temp user in backend and local storage
        final Map<String, dynamic> tempUserMap =
            await usrService.createAndGetTempUser();
        final tempUserID = tempUserMap["userId"];
        realmProxy.addUserId(tempUserID);

        // store donation info locally
        realmProxy.createCachedGivt(
            mediumId, donationAmount, dateTime, tempUserID);

        navigationService.navigateTo(routes.WepayRoute);
      } catch (error) {
        toggleLoader(false);
        SnackBarNotifyer(context)
            .showSnackBarMessage(error.toString(), Colors.red);
      }
    } else {
      SnackBarNotifyer(context).showSnackBarMessage(
          'You are not connected to the internet', Colors.red);
    }
  }
}
