import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/widgets/notifications/snackbar.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/controller/user_controller.dart';
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
    final usrController = UserController(context, null, null, null);

    final NavigationService navigationService = locator<NavigationService>();
    late final LocalStorageProxy realmProxy = locator<LocalStorageProxy>();
    toggleLoader(true);

    if (connected) {
      try {
        //create temp user in backend and local storage
        final Map<String, dynamic> tempUserMap =
            await usrController.createAndGetTempUser(null);
        final tempUserID = tempUserMap["userId"];
        realmProxy.addUserId(tempUserID);
        LocalUser localUser =
            realmProxy.realm.all<LocalStorage>().first.userData!;

        // store donation info locally
        realmProxy.createCachedGivt(
            mediumId, donationAmount, dateTime, tempUserID);

        /// just assurances bellow
        ///////////////////////////////////////////////////////
        CachedGivts? localDonation = realmProxy.realm
            .all<LocalStorage>()
            .first
            .cachedGivts
            .firstWhere((element) => element.userId == tempUserID);
        print(
            'Sucessfully created user ${localUser.userId} that matches $tempUserID, yay ${localUser.firstName}, user wants to donate ${localDonation.donationAmount}');
        //////////////////////////////////////////////////
        /// just assurances above

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
