import 'dart:io';

import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/models/localStorage.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import 'dart:math';
import 'dart:convert';
import '../../startup/pages/startup_page.dart';
import '../../../models/user.dart';
import '../../../services/api_service.dart';

class SplashScreenController {
  late final LocalStorageProxy realmProxy = locator<LocalStorageProxy>();
  BuildContext ctx;
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  SplashScreenController(this.ctx);

  Future<Widget> createTempUserAndNavigate() async {
    final tempUser = createTempUser();
    final encodedUser = getEncodedUser(tempUser);
    final String tempUserID = await APIService().createUser(encodedUser);
    if ((tempUserID is HttpException) == false) {
      return Future.value(const StartupPage());
    }
    realmProxy.addTempUserID(tempUserID);
    return Future.value(const StartupPage());
  }

  User createTempUser() {
    final locale = Localizations.localeOf(ctx).toString();
    return User(
        Email: getRandomGeneratedEmail(),
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
  }

  String getRandomGeneratedEmail() {
    final generatedString = String.fromCharCodes(Iterable.generate(
        5, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    return 'givttest+$generatedString@gmail.com';
  }

  String getEncodedUser(tempUser) {
    return json.encode({
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
  }
}
