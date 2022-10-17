import 'dart:io';

import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/models/localStorage.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import 'dart:math';
import 'dart:convert';
import '../../../models/temp-user.dart';
import '../../../models/user.dart';
import '../../../services/api_service.dart';

class UserController {
  late final LocalStorageProxy realmProxy = locator<LocalStorageProxy>();
  BuildContext ctx;
  String _firstName;
  String _lastName;
  String _postcode;
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  UserController(this.ctx, this._firstName, this._lastName, this._postcode);

  Future<Map<String, dynamic>> createAndGetRegisteredUser(
      String userID, dynamic tempUser) async {
    final user = User.fromTempUser(userID, tempUser);
    print('registered user : $user');
    final encodedUser = getEncodedUser(tempUser);
    final response = await APIService().createRegisteredUser(encodedUser);
    return jsonDecode(response);
  }

  Future<Map<String, dynamic>> createAndGetTempUser() async {
    final tempUser = createTempUser();
    final encodedUser = getEncodedTempUser(tempUser);
    final tempUserId = await APIService().createTempUser(encodedUser);
    Map<String, dynamic> tempUserMap = new Map<String, dynamic>();
    tempUserMap["userId"] = tempUserId;
    tempUserMap["user"] = tempUser;
    return tempUserMap;
  }

  TempUser createTempUser() {
    final locale = Localizations.localeOf(ctx).toString();
    return TempUser(
        Email: getRandomGeneratedEmail(),
        IBAN: 'FB66GIVT12345678',
        PhoneNumber: '060000000',
        FirstName: _firstName,
        LastName: _lastName,
        Address: 'Foobarstraat 5',
        City: 'Foobar',
        PostalCode: _postcode,
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

  String getEncodedTempUser(tempUser) {
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

  String getEncodedUser(user) {
    return json.encode({
      'userId': user.userId,
      'email': user.email,
      'phoneNumber': user.phoneNumber,
      'firstName': user.firstName,
      'lastName': user.lastName,
      'deviceOS': user.deviceOS,
      'postalCode': user.postalCode,
      'country': user.country,
      'password': user.password,
      'appLanguage': user.appLanguage,
      'timeZoneId': user.timeZoneId
    });
  }
}
