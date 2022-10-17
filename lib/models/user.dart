import 'dart:convert';

import 'package:givt_mobile_apps/models/temp-user.dart';

class User {
  final String userId;
  final String email;
  final String phoneNumber;
  final String password;
  final String appLanguage;
  final int deviceOS;
  final String country;
  final String postalCode;
  final String firstName;
  final String lastName;
  final String timeZoneId;

  User(
      {required this.email,
      required this.userId,
      required this.phoneNumber,
      required this.firstName,
      required this.lastName,
      required this.deviceOS,
      required this.postalCode,
      required this.country,
      required this.password,
      required this.appLanguage,
      required this.timeZoneId});

  factory User.fromTempUser(String userId, TempUser tempUser) {
    return User(
      userId: userId,
      email: tempUser.Email,
      deviceOS: 0,
      phoneNumber: tempUser.PhoneNumber,
      firstName: tempUser.FirstName,
      lastName: tempUser.LastName,
      postalCode: tempUser.PostalCode,
      country: tempUser.Country,
      password: tempUser.Password,
      appLanguage: tempUser.AppLanguage,
      timeZoneId: tempUser.TimeZoneId,
    );
  }
}
