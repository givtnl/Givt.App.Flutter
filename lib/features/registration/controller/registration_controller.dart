import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/models/local_storage.dart';
import 'package:givt_mobile_apps/services/local_storage_service.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import 'dart:convert';
import '../../../models/temp_user.dart';
import '../../../core/widgets/notifications/snackbar.dart';
import '../../../core/constants/route_paths.dart' as routes;
import '../../../services/api_service.dart';
import '../../../services/user_service.dart';

class RegistrationController {
  bool btnDisabled;
  String email;
  GlobalKey<FormState> formKey;
  BuildContext ctx;
  Function showLoader;
  late SnackBarNotifyer notifyer;
  RegistrationController(
      this.btnDisabled, this.formKey, this.email, this.ctx, this.showLoader);

  final NavigationService _navigationService = locator<NavigationService>();
  final UserService _userService = locator<UserService>();
  late final LocalStorageProxy storageProxy = locator<LocalStorageProxy>();

  Future<void> handleButtonClick() async {
    final form = formKey.currentState;
    FocusManager.instance.primaryFocus?.unfocus();
    if (form != null && form.validate()) {
      try {
        showLoader(true);
        final response = await checkTLDAndCreateTempUser(email);
        showLoader(false);
        SnackBarNotifyer(ctx)
            .showSnackBarMessage('User created successfully!', Colors.green);
        _navigationService.navigateTo(routes.DonationAmountTypicalRoute);
      } catch (error) {
        showLoader(false);
        SnackBarNotifyer(ctx).showSnackBarMessage(error.toString(), Colors.red);
      }
    }
  }

  Future checkTLDAndCreateTempUser(String email) async {
    bool response = await APIService().checktld(email);
    if (response) {
      return _userService.createAndGetTempUser();
    } else {
      throw 'Incorect Email domain used!';
    }
  }
}
