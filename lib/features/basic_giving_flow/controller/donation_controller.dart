import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/models/registered_user.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../controller/user_controller.dart';
import '../../../core/widgets/notifications/snackbar.dart';
import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';
import '../../../services/api_service.dart';
import '../../../core/constants/route_paths.dart' as routes;

class DonationController {
  final _navigationService = locator<NavigationService>();
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
        lastNameController.text, postcodeController.text);
    toggleLoader(true);

    try {
      //create temp user
      final Map<String, dynamic> tempUserMap =
          await usrController.createAndGetTempUser();
      final tempUserID = tempUserMap["userId"];
      //create registered user
      final response = await usrController.createAndGetRegisteredUser(
          tempUserID, tempUserMap["user"]);
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
      final response = await APIService().createMandate(wePayToken, userId);
      toggleLoader(false);
    } catch (error) {
      toggleLoader(false);
      SnackBarNotifyer(context)
          .showSnackBarMessage(error.toString(), Colors.red);
    }
  }
}
