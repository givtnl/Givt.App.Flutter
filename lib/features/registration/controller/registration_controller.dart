import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/models/localStorage.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import 'dart:convert';
import '../../../models/user.dart';
import '../../../core/widgets/notifications/snackbar.dart';
import '../../../core/constants/route_paths.dart' as routes;
import '../../../services/api_service.dart';

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
  late final LocalUserProxy realmProxy = locator<LocalUserProxy>();

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
      } catch (error) {
        showLoader(false);
        SnackBarNotifyer(ctx).showSnackBarMessage(error.toString(), Colors.red);
      }
    }
  }

  Future checkTLDAndCreateTempUser(String email) async {
    bool response = await APIService().checktld(email);
    if (response) {
      final locale = Localizations.localeOf(ctx).toString();
      final User tempUser = User(
          Email: email,
          IBAN: 'FB66GIVT12345678',
          PhoneNumber: '060000000',
          FirstName: 'John',
          LastName: 'Doe',
          Address: 'Foobarstraat 5',
          City: 'Foobar',
          PostalCode: '786 FB',
          Country: 'NL',
          Password: 'R4nd0mP@s\$w0rd123',
          AmountLimit: 499,
          AppLanguage: locale,
          TimeZoneId: DateTime.now().timeZoneName);
      final encodedUser = json.encode({
        'Email': tempUser.Email,
        'IBAN': tempUser.IBAN,
        'PhoneNumber': tempUser.PhoneNumber,
        'FirstName': tempUser.FirstName,
        'LastName': tempUser.LastName,
        'Address': tempUser.Address,
        'City': tempUser.City,
        'PostalCode': tempUser.PostalCode,
        'Country': tempUser.Country,
        'Password': tempUser.Password,
        'AmountLimit': tempUser.AmountLimit,
        'AppLanguage': tempUser.AppLanguage,
        'TimeZoneId': tempUser.TimeZoneId
      });
      final String tempUserID = await APIService().createUser(encodedUser);
      // create a realm local user
      realmProxy.createUser(
        tempUser.Email,
        tempUserID,
        tempUser.IBAN,
        tempUser.PhoneNumber,
        tempUser.FirstName,
        tempUser.LastName,
        tempUser.Address,
        tempUser.City,
        tempUser.PostalCode,
        tempUser.Country,
        tempUser.AmountLimit,
        tempUser.AppLanguage,
        tempUser.TimeZoneId,
      );
      _navigationService.navigateTo(routes.DonationAmountTypicalRoute);
      return tempUserID;
    } else {
      throw 'Incorect Email domain used!';
    }
  }
}
