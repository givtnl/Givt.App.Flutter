import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/widgets/notifications/snackbar.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
import '../../../../services/api_service.dart';
import '../../../models/localStorage.dart';
import '../../../utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

class LoginController {
  late final LocalStorageProxy realmProxy = locator<LocalStorageProxy>();
  late final NavigationService _navigationService =
      locator<NavigationService>();

  void onLogin(BuildContext context, String email, String password,
      Function toggleLoader) async {
    print('loggin in');
    final Map data = {
      'grant_type': 'password',
      'userName': email,
      'password': password
    };
    try {
      final response = await APIService().loginLocal(data);
      final decodedRes = jsonDecode(response);
      // this should be stored locally or in state,
      // then there needs to be a service that keeps the login active with bearer plus access token
      // but fixes on local storage and decisions on state management should happen first
      print('access token is: ${decodedRes['access_token']}');
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
