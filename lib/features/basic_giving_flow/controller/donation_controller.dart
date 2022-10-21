import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/models/localStorage.dart';
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
      Map<String, String> _formValue,
      InAppWebViewController webViewController,
      Function toggleLoader) async {
    var hasSpaceChar = _formValue['name']!.contains(' ');
    late String firstName;
    late String lastName;
    if (hasSpaceChar) {
      firstName =
          _formValue['name']!.substring(0, _formValue['name']!.indexOf(' '));
      lastName = _formValue['name']!.substring(
          _formValue['name']!.indexOf(' ') + 1, _formValue['name']!.length);
    } else {
      firstName = _formValue['name']!;
      lastName = '';
    }
    final usrController =
        UserController(context, firstName, lastName, _formValue['postalCode']);
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
