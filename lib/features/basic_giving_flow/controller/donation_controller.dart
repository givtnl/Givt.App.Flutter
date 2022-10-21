import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/models/localStorage.dart';
import 'package:givt_mobile_apps/models/registered_user.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart'
    hide LocalStorage;
import 'package:givt_mobile_apps/models/submitted_donation.dart';
import '../controller/user_controller.dart';
import '../../../core/widgets/notifications/snackbar.dart';
import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';
import '../../../services/api_service.dart';
import '../../../core/constants/route_paths.dart' as routes;

class DonationController {
  final _navigationService = locator<NavigationService>();
  late final LocalStorageProxy realmProxy = locator<LocalStorageProxy>();
  final NavigationService navigationService = locator<NavigationService>();

  late final String _registeredUserId;

  void initialiseDonationProcess(
      BuildContext context,
      firstNameController,
      lastNameController,
      postcodeController,
      InAppWebViewController webViewController,
      Function setRegisteredUserId,
      Function toggleLoader) async {
    final usrController = UserController(context, firstNameController.text,
        lastNameController, postcodeController.text);
    toggleLoader(true);

    try {
      //update temp user with ID
      LocalUser localUser =
          realmProxy.realm.all<LocalStorage>().first.userData!;
      final Map<String, dynamic> tempUserMap =
          await usrController.createAndGetTempUser(localUser.userId);
      //create registered user
      final response = await usrController.createAndGetRegisteredUser(
          localUser.userId, tempUserMap["user"]);
      print(response.toString());
      setRegisteredUserId(response.userId);
      webViewController.evaluateJavascript(source: "tokenize();");
    } catch (error) {
      toggleLoader(false);
      SnackBarNotifyer(context)
          .showSnackBarMessage(error.toString(), Colors.red);
    }
  }

  void createMandateAndSubmitDonation(String wePayToken, Function toggleLoader,
      BuildContext context, String userId) async {
    try {
      // create the jsonDonation
      final jsonDonation = Donation(wepayToken: wePayToken).jsonDonation();
      print(jsonDonation);
      final responseDonation =
          await APIService().submitDonation(userId, jsonDonation);
      final responseMandate =
          await APIService().createMandate(wePayToken, userId);
      navigationService.navigateTo(routes.DonationSuccessRoute);
      toggleLoader(false);
    } catch (error) {
      toggleLoader(false);
      print(error);
      SnackBarNotifyer(context)
          .showSnackBarMessage(error.toString(), Colors.red);
    }
  }
}
