import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/widgets/notifications/snackbar.dart';
import 'package:givt_mobile_apps/services/user_service.dart';
import 'package:givt_mobile_apps/models/localStorage.dart';

import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

class AmountController {
  final NavigationService navigationService = locator<NavigationService>();
  Future<void> storeCachedGivt(context, double donationAmount, String mediumId,
      Function toggleLoader) async {
    String dateTime = DateTime.now().toIso8601String();
    final UserService usrService = locator<UserService>();

    late final LocalStorageProxy realmProxy = locator<LocalStorageProxy>();
    toggleLoader(true);
    try {
      //create temp user in backend and local storage
      final Map<String, dynamic> tempUserMap =
          await usrService.createAndGetTempUser();
      final tempUserID = tempUserMap["userId"];
      realmProxy.addUserId(tempUserID);

      // store donation info locally
      realmProxy.createCachedGivt(
          mediumId, donationAmount, dateTime, tempUserID);
      toggleLoader(false);
    } catch (error) {
      toggleLoader(false);
      SnackBarNotifyer(context)
          .showSnackBarMessage(error.toString(), Colors.red);
    }
  }

  navigateToPayment() {
    navigationService.navigateTo(routes.WepayRoute);
  }
}
