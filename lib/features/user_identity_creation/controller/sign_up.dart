import 'package:flutter/material.dart';

import '../../../../services/api_service.dart';
import '../../../core/widgets/notifications/snackbar.dart';
import '../../../models/localStorage.dart';
import '../../../services/user_service.dart';
import '../../../utils/locator.dart';

class SignUpController {
  late final LocalStorageProxy realmProxy = locator<LocalStorageProxy>();

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
          Theme.of(context).colorScheme.primary);
    }
    if (emailStatus.contains('dashboard')) {
      SnackBarNotifyer(context).showSnackBarMessage(
          'Dashboard user, what now?', Theme.of(context).colorScheme.primary);
    }
    if (emailStatus.contains('temp')) {
      //hmmmmmmm
    }
    if (emailStatus.contains('false')) {
      if (localUser.userId.isEmpty) {
        final tempUserMap = await _userService.createAndGetTempUser(
            context,
            formValue['firstName'],
            formValue['lastName'],
            null,
            formValue['email']);
        realmProxy.addUserId(tempUserMap["userId"]);
        print(localUser.userId);
      }
      print('haha here now');
      // send put request with password
      SnackBarNotifyer(context).showSnackBarMessage(
          'New User', Theme.of(context).colorScheme.primary);
    }
  }
}
