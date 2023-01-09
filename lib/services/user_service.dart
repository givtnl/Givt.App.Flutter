import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/models/local_storage.dart';
import 'package:givt_mobile_apps/services/local_user_service.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import 'dart:math';
import 'dart:convert';
import '../models/temp_user.dart';
import '../models/registered_user.dart';
import 'api_service.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class UserService {
  late final LocalUserService localUserService = locator<LocalUserService>();
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();
  final apiService = locator<APIService>();

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
    localUserService.postLocalUser(regUser);
    await apiService.createRegisteredUser(regUser);
    return regUser;
  }

  Future<dynamic> createAndGetRegisteredUser(TempUser tempUser) async {
    final registeredUser = RegisteredUser.fromTempUser(tempUser);
    localUserService.postLocalUser(registeredUser);
    await apiService.createRegisteredUser(registeredUser);
    return registeredUser;
  }

  Future<TempUser> createAndGetTempUser(
      [BuildContext? ctx,
      String? firstName,
      String? lastName,
      String? postcode,
      String? email,
      String? password]) async {
    final TempUser tempUser = await createTempUser(
        ctx, firstName, lastName, postcode, email, password);
    final tempUserId = await apiService.createTempUser(tempUser);
    tempUser.UserId = tempUserId;
    return tempUser;
  }

  Future<void> loginUser(Map loginCredentials) async {
    final response = await apiService.login(loginCredentials);
    final decodedRes = jsonDecode(response);
    // the access token should be stored locally or in state,
    // then there needs to be a service that keeps the login active with bearer plus access token
    // but fixes on local storage and decisions on state management should happen first
    final user = RegisteredUser.fromLoginData(
        decodedRes['GUID'],
        decodedRes['Email'],
        decodedRes['access_token'],
        decodedRes['refresh_token'],
        decodedRes['.expires'],
        decodedRes['expires_in']);
    /// Save token into localUserService
    localUserService.postLocalUser(user);
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

    LocalUser localUser = localUserService.getLocalUser();
    return TempUser(
        UserId: (localUser.userId.isNotEmpty) ? localUser.userId : null,
        Email: email ?? getRandomGeneratedEmail(),
        IBAN: 'FB66GIVT12345678',
        PhoneNumber: '060000000',
        FirstName: firstName ?? 'john',
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
