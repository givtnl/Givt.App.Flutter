import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../models/user.dart';
import '../../../core/constants/environment_variables.dart';
import '../../../core/widgets/notifications/snackbar.dart';

class RegistrationController {
  bool btnDisabled;
  String email;
  GlobalKey<FormState> formKey;
  BuildContext ctx;
  late SnackBarNotifyer notifyer;
  RegistrationController(this.btnDisabled, this.formKey, this.email, this.ctx);

  handleButtonClick() async {
    final form = formKey.currentState;
    FocusManager.instance.primaryFocus?.unfocus();
    if (form != null && form.validate()) {
      try {
        final response = await checkTLDAndCreateTempUser(email);
        SnackBarNotifyer(ctx).showSnackBarMessage(
            'Temp User created successfully!', Colors.green);
      } catch (error) {
        SnackBarNotifyer(ctx).showSnackBarMessage(error.toString(), Colors.red);
      }
    }
  }

  Future checkTLDAndCreateTempUser(String email) async {
    var client = http.Client();
    try {
      final url = Uri.https(baseApiUrl, '/api/checktld', {'email': email});
      var response = await client.get(url);
      var decodedResponse = json.decode(response.body);
      if (decodedResponse) {
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
        final url = Uri.https(baseApiUrl, '/api/v2/users');
        return await client.post(url,
            body: json.encode({
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
            }));
      } else {
        throw HttpException('Incorect Email domain used!');
      }
    } finally {
      client.close();
    }
  }
}
