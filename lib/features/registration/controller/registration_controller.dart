import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../../../models/user.dart';
import '../../../core/constants/environment_variables.dart';
import '../../../core/widgets/notifications/snackbar.dart';
import '../../../utils/givtapi.dart';

class RegistrationController {
  bool btnDisabled;
  String email;
  GlobalKey<FormState> formKey;
  BuildContext ctx;
  Function showLoader;
  late SnackBarNotifyer notifyer;
  RegistrationController(
      this.btnDisabled, this.formKey, this.email, this.ctx, this.showLoader);

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
    bool response = await GivtAPI().checktld(email);
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
      return await GivtAPI().createUser(encodedUser);
    } else {
      throw 'Incorect Email domain used!';
    }
  }
}
