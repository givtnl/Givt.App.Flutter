import 'dart:io';
import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/widgets/notifications/snackbar.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/controller/user_controller.dart';
import 'package:givt_mobile_apps/models/localStorage.dart';
import 'package:givt_mobile_apps/models/registered_user.dart';
import 'package:givt_mobile_apps/utils/connection_check.dart';

import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

class AmountController {
  Future<void> createCachedGivtandNavigate(
      context, int donationAmount, String mediumId) async {
    bool connected = await tryConnection();
    DateTime dateTime = DateTime.now();
    final usrController = UserController(context, null, null, null);

    final NavigationService navigationService = locator<NavigationService>();
    late final LocalStorageProxy realmProxy = locator<LocalStorageProxy>();

// fourth arg is null bc the current flow doesnt register the email so it does not fetch the userId
    //model.createCachedGivt(mediumId, donationAmount, dateTime, null);
    if (connected) {
      try {
        //create temp user in backend and local storage
        final Map<String, dynamic> tempUserMap =
            await usrController.createAndGetTempUser(null);
        final tempUserID = tempUserMap["userId"];
        // store donation info locally
        realmProxy.createCachedGivt(
            mediumId, donationAmount, dateTime, tempUserID);

        /// just assurances bellow
        ///////////////////////////////////////////////////////
        LocalUser localUser =
            realmProxy.realm.all<LocalStorage>().first.userData!;
        CachedGivts? localDonation = realmProxy.realm
            .all<LocalStorage>()
            .first
            .cachedGivts
            .firstWhere((element) => element.userId == tempUserID);
        print(
            'Sucessfully created user ${localUser.userId} that matches $tempUserID, yay ${localUser.firstName}, user wants to donate ${localDonation.donationAmount}');
        //////////////////////////////////////////////////
        /// just assurances above
        if (Platform.isIOS) {
          // this should direct to ifram in the inapp browser bc of apple store policies
          navigationService.navigateTo(routes.WepayRoute);
        } else {
          // this should direct to iframe in the app
          navigationService.navigateTo(routes.WepayRoute);
        }
      } catch (error) {
        SnackBarNotifyer(context)
            .showSnackBarMessage(error.toString(), Colors.red);
      }
    } else {
      SnackBarNotifyer(context).showSnackBarMessage(
          'You are not connected to the internet', Colors.red);
    }
  }
}
