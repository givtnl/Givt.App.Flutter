import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
import '../../../../services/api_service.dart';
import '../../../core/widgets/notifications/snackbar.dart';
import '../../../models/localStorage.dart';
import '../../../services/user_service.dart';
import '../../../utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

class SignUpController {
  late final LocalStorageProxy realmProxy = locator<LocalStorageProxy>();
  late final NavigationService _navigationService =
      locator<NavigationService>();

  void onSignUp(BuildContext context, Map<String, String> formValue,
      Function toggleLoader) async {
    LocalUser localUser = realmProxy.realm.all<LocalStorage>().first.userData!;
    final UserService _userService = locator<UserService>();

    final String emailStatus =
        await APIService().checkEmailExists(formValue['email']!);
    print(emailStatus);
    toggleLoader(false);

    if (emailStatus.contains('true')) {
      SnackBarNotifyer(context).showSnackBarMessage(
          'Email already registered, login instead?',
          Theme.of(context).primaryColor);
      toggleLoader(false);
      _navigationService.navigateTo(routes.LoginRoute,
          arguments: formValue['email']);
    }
    if (emailStatus.contains('dashboard') || emailStatus.contains('temp')) {
      // these users do not have a payment details but can log in
      SnackBarNotifyer(context).showSnackBarMessage(
          'Email already registered, login instead?',
          Theme.of(context).primaryColor);
      toggleLoader(false);
      _navigationService.navigateTo(routes.LoginRoute,
          arguments: formValue['email']);
    }
    if (emailStatus.contains('false')) {
      if (localUser.userId.length < 2) {
        // impossible to get here in our current flow, but might be used later.
        final tempUserMap = await _userService.createAndGetTempUser(
          context,
          formValue['firstName'],
          formValue['lastName'],
          null,
          formValue['email'],
          formValue['password'],
        );

        /// post to api/v2/users/register creates a dashboard user that does not get removed,
        /// but if user completes donation they become 'multiuser'/'true'
        final response = await _userService.createAndGetRegisteredUser(
            tempUserMap['userId'], tempUserMap["user"]);
        toggleLoader(false);
        _navigationService.navigateTo(routes.HomeScreenRoute);
      } else {
        ////////////  HAPPY PATH in current giving flow ////////////
        final res = await _userService.postRegisteredUser(
          context,
          formValue['firstName'],
          formValue['lastName'],
          null,
          formValue['email'],
          formValue['password'],
          localUser.userId,
        );
        _navigationService.navigateTo(routes.HomeScreenRoute);
        toggleLoader(false);
      }
    }
  }
}
