import 'package:json_annotation/json_annotation.dart';
part 'temp_user.g.dart';

@JsonSerializable()
class TempUser {
  String? UserId;
  final String Email;
  final String IBAN;
  final String PhoneNumber;
  final String FirstName;
  final String LastName;
  final String Address;
  final String City;
  final String PostalCode;
  final String Country;
  final String Password;
  final int AmountLimit;
  final String AppLanguage;
  final String TimeZoneId;

  TempUser(
      {this.UserId,
      required this.Email,
      required this.IBAN,
      required this.PhoneNumber,
      required this.FirstName,
      required this.LastName,
      required this.Address,
      required this.City,
      required this.PostalCode,
      required this.Country,
      required this.Password,
      required this.AmountLimit,
      required this.AppLanguage,
      required this.TimeZoneId});

  factory TempUser.fromJson(Map<String, dynamic> json) =>
      _$TempUserFromJson(json);

  Map<String, dynamic> toJson() => _$TempUserToJson(this);
}
