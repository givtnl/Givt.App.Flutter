import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/models/localStorage.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart'
    hide LocalStorage;
import 'package:givt_mobile_apps/models/temp_user.dart';
import '../../../services/user_service.dart';
import '../../../core/widgets/notifications/snackbar.dart';
import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';
import '../../../services/api_service.dart';
import '../../../core/constants/route_paths.dart' as routes;

class DonationController {
  late final LocalStorageProxy storageProxy = locator<LocalStorageProxy>();
  final NavigationService navigationService = locator<NavigationService>();

  void initialiseDonationProcess(
      BuildContext context,
      Map<String, String> formValue,
      InAppWebViewController webViewController,
      Function toggleLoader) async {
    late String firstName = formValue['name']!;
    late String lastName = '';
    final UserService usrService = locator<UserService>();
    toggleLoader(true);

    try {
      final TempUser tempUser = await usrService.createTempUser(
          context, firstName, lastName, formValue['postalCode']);
      //create registered user
      final registeredUser =
          await usrService.createAndGetRegisteredUser(tempUser);
      storageProxy.createUser(registeredUser);
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
      await APIService().submitDonation(userId, wePayToken);
      await APIService().createMandate(wePayToken, userId);
      navigationService.navigateTo(routes.DonationSuccessRoute);
      toggleLoader(false);
    } catch (error) {
      toggleLoader(false);
      SnackBarNotifyer(context)
          .showSnackBarMessage(error.toString(), Colors.red);
    }
  }

  Future<void> storeCachedGivt(context, double donationAmount, String mediumId,
      Function toggleLoader) async {
    String dateTime = DateTime.now().toIso8601String();
    final UserService usrService = locator<UserService>();

    late final LocalStorageProxy storageProxy = locator<LocalStorageProxy>();
    toggleLoader(true);
    try {
      //create temp user in backend and local storage
      final TempUser tempUser = await usrService.createAndGetTempUser();
      storageProxy.addUserId(tempUser.Guid!);

      // store donation info into local storage
      storageProxy.createCachedGivt(
          mediumId, donationAmount, dateTime, tempUser.Guid!);
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
