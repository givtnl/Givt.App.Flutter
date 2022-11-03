import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/models/localStorage.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart'
    hide LocalStorage;
import 'package:givt_mobile_apps/models/donation.dart';
import '../../../services/user_service.dart';
import '../../../core/widgets/notifications/snackbar.dart';
import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';
import '../../../services/api_service.dart';
import '../../../core/constants/route_paths.dart' as routes;

class DonationController {
  late final LocalStorageProxy realmProxy = locator<LocalStorageProxy>();
  final NavigationService navigationService = locator<NavigationService>();

  late final String _registeredUserId;

  void initialiseDonationProcess(
      BuildContext context,
      Map<String, String> _formValue,
      InAppWebViewController webViewController,
      Function toggleLoader) async {
    late String firstName = _formValue['name']!;
    late String lastName = '';
    final UserService usrService = locator<UserService>();
    toggleLoader(true);

    try {
      //update temp user with ID
      LocalUser localUser =
          realmProxy.realm.all<LocalStorage>().first.userData!;
      final tempUser = await usrService.createTempUser(
          context, firstName, lastName, _formValue['postalCode']);
      //create registered user
      final registeredUser = await usrService.createAndGetRegisteredUser(
          localUser.userId, tempUser);
      realmProxy.createUser(registeredUser);
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
      final responseDonation =
          await APIService().submitDonation(userId, jsonDonation);
      final responseMandate =
          await APIService().createMandate(wePayToken, userId);
      navigationService.navigateTo(routes.DonationSuccessRoute);
      toggleLoader(false);
    } catch (error) {
      toggleLoader(false);
      SnackBarNotifyer(context)
          .showSnackBarMessage(error.toString(), Colors.red);
    }
  }
}
