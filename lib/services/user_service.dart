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

  Future<dynamic> createAndGetRegisteredUser(TempUser tempUser) async {
    final registeredUser = RegisteredUser.fromTempUser(tempUser);
    storageProxy.createUser(registeredUser);
    await APIService().createRegisteredUser(registeredUser);
    return registeredUser;
  }

  Future<TempUser> createAndGetTempUser(
      [BuildContext? ctx,
      String? firstName,
      String? lastName,
      String? postcode,
      String? email]) async {
    final TempUser tempUser =
        await createTempUser(ctx, firstName, lastName, postcode, email);
    final tempUserId = await APIService().createTempUser(tempUser);
    tempUser.Guid = tempUserId;
    return tempUser;
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
    LocalUser localUser =
        storageProxy.realm.all<LocalStorage>().first.userData!;
    return TempUser(
        Guid: (localUser.userId.isNotEmpty) ? localUser.userId : null,
        Email: email ?? getRandomGeneratedEmail(),
        IBAN: 'NL62AAAA8705076482',
        PhoneNumber: '060000000',
        FirstName: firstName ?? 'jhon',
        LastName: lastName ?? 'doe',
        Address: 'Foobarstraat 5',
        City: 'Foobar',
        PostalCode: postcode ?? 'no zipcode',
        Country: 'NL',
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
