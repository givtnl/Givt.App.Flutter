import 'dart:io';

import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/models/localStorage.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import 'dart:math';
import 'dart:convert';
import '../models/temp_user.dart';
import '../models/registered_user.dart';
import 'api_service.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class UserService {
  late final LocalStorageProxy storageProxy = locator<LocalStorageProxy>();
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  UserService();

  Future<dynamic> updateUserIdentity(
      [BuildContext? ctx,
      String? firstName,
      String? lastName,
      String? postcode,
      String? email,
      String? password,
      String? guid]) async {
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    final String locale =
        (ctx != null) ? Localizations.localeOf(ctx).toString() : 'en';
    final regUser = await RegisteredUser.fromSignUpData(
        guid!, email!, password!, currentTimeZone, locale);
    storageProxy.createUser(regUser);
    final encodedUser = jsonEncode(regUser);
    await APIService().createRegisteredUser(encodedUser);
    return regUser;
  }

  Future<dynamic> createAndGetRegisteredUser(
      String userID, dynamic tempUser) async {
    final registeredUser = RegisteredUser.fromTempUser(userID, tempUser);
    storageProxy.createUser(registeredUser);
    final encodedUser = jsonEncode(registeredUser);
    await APIService().createRegisteredUser(encodedUser);
    return registeredUser;
  }

  Future<Map<String, dynamic>> createAndGetTempUser(
      [BuildContext? ctx,
      String? firstName,
      String? lastName,
      String? postcode,
      String? email,
      String? password]) async {
    final tempUser = await createTempUser(
        ctx, firstName, lastName, postcode, email, password);
    final encodedUser = jsonEncode(tempUser);
    final tempUserId = await APIService().createTempUser(encodedUser);
    Map<String, dynamic> tempUserMap = Map<String, dynamic>();
    tempUserMap["userId"] = tempUserId;
    tempUserMap["user"] = tempUser;
    return tempUserMap;
  }

  Future<String> loginUser(Map loginCredentials) async {
    final response = await APIService().login(loginCredentials);
    final decodedRes = jsonDecode(response);
    // the access token should be stored locally or in state,
    // then there needs to be a service that keeps the login active with bearer plus access token
    // but fixes on local storage and decisions on state management should happen first
    return 'logged in';
  }

  Future<TempUser> createTempUser(
      [BuildContext? ctx,
      String? firstName,
      String? lastName,
      String? postcode,
      String? email,
      String? password]) async {
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    return TempUser(
        Email: email ?? getRandomGeneratedEmail(),
        IBAN: 'NL62AAAA8705076482',
        PhoneNumber: '060000000',
        FirstName: firstName ?? 'jhon',
        LastName: lastName ?? 'doe',
        Address: 'Foobarstraat 5',
        City: 'Foobar',
        PostalCode: postcode ?? 'no zipcode',
        Country: 'US',
        Password: password ?? 'R4nd0mP@s\$w0rd123',
        AmountLimit: 499,
        AppLanguage:
            (ctx != null) ? Localizations.localeOf(ctx).toString() : 'en',
        TimeZoneId: currentTimeZone);
  }

  String getRandomGeneratedEmail() {
    final generatedString = String.fromCharCodes(Iterable.generate(
        5, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    return 'givttest+$generatedString@gmail.com';
  }
}
