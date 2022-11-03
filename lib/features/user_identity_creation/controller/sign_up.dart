import 'package:flutter/material.dart';

import '../../../../services/api_service.dart';
import '../../../core/widgets/notifications/snackbar.dart';
import '../../../models/localStorage.dart';
import '../../../services/user_service.dart';
import '../../../utils/locator.dart';

class SignUpController {
  late final LocalStorageProxy realmProxy = locator<LocalStorageProxy>();
  void onLogin(Function toggleLoader) async {
    print('loggin in');
    final response = await APIService().loginLocal();
    print(response);
    toggleLoader(false);
  }

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
          'Email already registered, login instead?', Colors.red);
      toggleLoader(false);
    }
    if (emailStatus.contains('dashboard') || emailStatus.contains('temp')) {
      // these users do not have a payment details
      SnackBarNotifyer(context).showSnackBarMessage(
          'Email already registered, login instead?', Colors.red);
      toggleLoader(false);
    }
    if (emailStatus.contains('false')) {
      if (localUser.userId.length < 2) {
        final tempUserMap = await _userService.createAndGetTempUser(
          context,
          formValue['firstName'],
          formValue['lastName'],
          null,
          formValue['email'],
          formValue['password'],
        );
        // post to api/v2/users/register creates a dashboard user
        final response = await _userService.createAndGetRegisteredUser(
            tempUserMap['userId'], tempUserMap["user"]);
        toggleLoader(false);
      } else {
        ////////////  HAPPY PATH ////////////
        final res = await _userService.postRegisteredUser(
          context,
          formValue['firstName'],
          formValue['lastName'],
          null,
          formValue['email'],
          formValue['password'],
          localUser.userId,
        );

        toggleLoader(false);
      }
    }
  }
}
