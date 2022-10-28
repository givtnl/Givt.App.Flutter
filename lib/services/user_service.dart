import 'dart:io';

import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/models/localStorage.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import 'dart:math';
import 'dart:convert';
import '../models/temp-user.dart';
import '../models/registered_user.dart';
import 'api_service.dart';

class UserService {
  late final LocalStorageProxy realmProxy = locator<LocalStorageProxy>();
  BuildContext ctx;
  String? _firstName;
  String? _lastName;
  String? _postcode;
  String? _email;
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  UserService(
      this.ctx, this._email, this._firstName, this._lastName, this._postcode);

  Future<dynamic> createAndGetRegisteredUser(
      String userID, dynamic tempUser) async {
    final registeredUser = RegisteredUser.fromTempUser(userID, tempUser);
    // Update Registered user to Realms DB (Local State storage)
    realmProxy.createUser(registeredUser);
    final encodedUser = getEncodedUser(registeredUser);
    await APIService().createRegisteredUser(encodedUser);
    return registeredUser;
  }

  Future<Map<String, dynamic>> createAndGetTempUser(String? userId) async {
    final tempUser = createTempUser();
    final encodedUser = getEncodedTempUser(tempUser);
    if (userId != null) {
      LocalUser localUser =
          realmProxy.realm.all<LocalStorage>().first.userData!;
      Map<String, dynamic> tempUserMap = Map<String, dynamic>();
      tempUserMap["userId"] = localUser.userId;
      tempUserMap["user"] = tempUser;
      return tempUserMap;
    } else {
      final tempUserId = await APIService().createTempUser(encodedUser);
      Map<String, dynamic> tempUserMap = Map<String, dynamic>();
      tempUserMap["userId"] = tempUserId;
      tempUserMap["user"] = tempUser;
      return tempUserMap;
    }
  }

  TempUser createTempUser() {
    final locale = Localizations.localeOf(ctx).toString();
    return TempUser(
        Email: _email ?? getRandomGeneratedEmail(),
        IBAN: 'FB66GIVT12345678',
        PhoneNumber: '060000000',
        FirstName: _firstName ?? 'jhon',
        LastName: _lastName ?? 'doe',
        Address: 'Foobarstraat 5',
        City: 'Foobar',
        PostalCode: _postcode ?? 'no zipcode',
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
