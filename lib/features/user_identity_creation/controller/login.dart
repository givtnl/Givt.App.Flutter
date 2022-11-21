import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/widgets/notifications/snackbar.dart';
import 'package:givt_mobile_apps/services/local_storage_service.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
import 'package:givt_mobile_apps/services/user_service.dart';
import '../../../../services/api_service.dart';
import '../../../models/local_storage.dart';
import '../../../utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

class LoginController {
  late final LocalStorageProxy realmProxy = locator<LocalStorageProxy>();
  late final NavigationService _navigationService =
      locator<NavigationService>();
  final UserService _userService = locator<UserService>();

  void login(BuildContext context, String email, String password,
      Function toggleLoader) async {
    print('loggin in');
    final Map loginCredentials = {
      'grant_type': 'password',
      'userName': email,
      'password': password
    };
    try {
      final response = await _userService.loginUser(loginCredentials);
      toggleLoader(false);
      _navigationService.navigateTo(routes.HomeScreenRoute);
    } catch (e) {
      print(e);
      toggleLoader(false);
      SnackBarNotifyer(context)
          .showSnackBarMessage('Log in failed', Colors.red);
    }
  }
}
