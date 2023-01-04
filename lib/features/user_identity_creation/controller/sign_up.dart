import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/services/local_storage_service.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
import '../../../../services/api_service.dart';
import '../../../core/widgets/notifications/snackbar.dart';
import '../../../models/local_storage.dart';
import '../../../models/temp_user.dart';
import '../../../services/user_service.dart';
import '../../../utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

class SignUpController {
  late final LocalStorageBase storageProxy = locator<LocalStorageBase>();
  late final NavigationService _navigationService =
      locator<NavigationService>();
  final apiService = locator<APIService>();

  void signUp(BuildContext context, Map<String, String> formValue,
      Function toggleLoader) async {
    LocalUser localUser =
        storageProxy.realm.all<LocalStorage>().first.userData!;
    final UserService _userService = locator<UserService>();

    final String emailExists =
        await apiService.checkEmailExists(formValue['email']!);
    log(emailExists);
    toggleLoader(false);

    if (emailExists.contains('false')) {
      if (localUser.userId.length < 2) {
        // impossible to get here in our current flow, but might be used later.
        final TempUser tempUser = await _userService.createAndGetTempUser(
          context,
          formValue['firstName'],
          formValue['lastName'],
          null,
          formValue['email'],
          formValue['password'],
        );

        /// post to api/v2/users/register creates a dashboard user that does not get removed,
        /// but if user completes donation they become 'multiuser'/'true'
        final response =
            await _userService.createAndGetRegisteredUser(tempUser);
        toggleLoader(false);
        _navigationService.navigateTo(routes.HomeScreenRoute);
        return;
      }
      ////////////  HAPPY PATH in current giving flow ////////////
      final res = await _userService.updateUserIdentity(
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
    } else {
      SnackBarNotifyer(context).showSnackBarMessage(
          'Email already registered, login instead?',
          Theme.of(context).primaryColor);
      toggleLoader(false);
      _navigationService.navigateTo(routes.LoginRoute,
          arguments: formValue['email']);
    }
  }
}
