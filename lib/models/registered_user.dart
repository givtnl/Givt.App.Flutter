import 'package:json_annotation/json_annotation.dart';
import 'package:givt_mobile_apps/models/temp_user.dart';
part 'registered_user.g.dart';

@JsonSerializable()
class RegisteredUser {
  final String guid;
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

  RegisteredUser(
      {required this.email,
      required this.guid,
      required this.phoneNumber,
      required this.firstName,
      required this.lastName,
      required this.deviceOS,
      required this.postalCode,
      required this.country,
      required this.password,
      required this.appLanguage,
      required this.timeZoneId});

  factory RegisteredUser.fromTempUser(TempUser tempUser) {
    return RegisteredUser(
      guid: tempUser.Guid!,
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
  factory RegisteredUser.fromSignUpData(String userId, String email,
      String password, String timezone, String locale) {
    return RegisteredUser(
      guid: userId,
      email: email,
      deviceOS: 0,
      phoneNumber: '060000000',
      firstName: 'john',
      lastName: 'doe',
      postalCode: 'no zipcode',
      country: 'US',
      password: password,
      appLanguage: locale,
      timeZoneId: timezone,
    );
  }

  factory RegisteredUser.fromJson(Map<String, dynamic> json) =>
      _$RegisteredUserFromJson(json);

  Map<String, dynamic> toJson() => _$RegisteredUserToJson(this);
}
