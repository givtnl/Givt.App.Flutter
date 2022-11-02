import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../services/api_service.dart';
import '../../../core/widgets/notifications/snackbar.dart';
import '../../../models/localStorage.dart';
import '../../../models/registered_user.dart';
import '../../../models/temp-user.dart';
import '../../../services/user_service.dart';
import '../../../utils/locator.dart';

class SignUpController {
  late final LocalStorageProxy realmProxy = locator<LocalStorageProxy>();

  void onSignUp(BuildContext context, Map<String, String> formValue,
      Function toggleLoader) async {
    LocalUser localUser = realmProxy.realm.all<LocalStorage>().first.userData!;
    final usrService = UserService(
        context,
        formValue['email'],
        formValue['password'],
        formValue['firstName'],
        formValue['lastName'],
        null);

    TempUser tempUser = await usrService.createTempUser();
    String encodedTempUser = usrService.getEncodedTempUser(tempUser);

    final String emailStatus =
        await APIService().checkEmailExists(formValue['email']!);
    print(emailStatus);
    toggleLoader(false);

    if (emailStatus.contains('true')) {
      SnackBarNotifyer(context).showSnackBarMessage(
          'Email already registered, login instead?',
          Theme.of(context).colorScheme.primary);
    }
    if (emailStatus.contains('dashboard')) {
      SnackBarNotifyer(context).showSnackBarMessage(
          'Dashboard user, what now?', Theme.of(context).colorScheme.primary);
    }
    if (emailStatus.contains('temp')) {
      if (localUser.userId.isEmpty) {
        // weird, maybe they made a donation with a previous phone but never registered with password
        // user has call api/v2/users/regster
      } else {
        // user has id so calll api/v2/users/regster
      }
    }
    if (emailStatus.contains('false')) {
      if (localUser.userId.length < 2) {
        final tempUserMap = await usrService.createAndGetTempUser(null);
        print(tempUserMap['userId']);
        // post to api/v2/users/register creates a dashboard user
        // final response = await usrService.createAndGetRegisteredUser(
        //  tempUserMap['userId'], tempUserMap["user"]);
        toggleLoader(false);
      } else {
        final registeredUser =
            RegisteredUser.fromTempUser(localUser.userId, tempUser);
        final encodedUser = usrService.getEncodedUser(registeredUser);
        // post to api/v2/users/register creates a dashboard user
        final response = await APIService().createRegisteredUser(encodedUser);
        toggleLoader(false);
      }
    }
  }
}
