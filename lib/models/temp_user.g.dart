// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temp_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TempUser _$TempUserFromJson(Map<String, dynamic> json) => TempUser(
      UserId: json['UserId'] as String?,
      Email: json['Email'] as String,
      IBAN: json['IBAN'] as String,
      PhoneNumber: json['PhoneNumber'] as String,
      FirstName: json['FirstName'] as String,
      LastName: json['LastName'] as String,
      Address: json['Address'] as String,
      City: json['City'] as String,
      PostalCode: json['PostalCode'] as String,
      Country: json['Country'] as String,
      Password: json['Password'] as String,
      AmountLimit: json['AmountLimit'] as int,
      AppLanguage: json['AppLanguage'] as String,
      TimeZoneId: json['TimeZoneId'] as String,
    );

Map<String, dynamic> _$TempUserToJson(TempUser instance) => <String, dynamic>{
      'UserId': instance.UserId,
      'Email': instance.Email,
      'IBAN': instance.IBAN,
      'PhoneNumber': instance.PhoneNumber,
      'FirstName': instance.FirstName,
      'LastName': instance.LastName,
      'Address': instance.Address,
      'City': instance.City,
      'PostalCode': instance.PostalCode,
      'Country': instance.Country,
      'Password': instance.Password,
      'AmountLimit': instance.AmountLimit,
      'AppLanguage': instance.AppLanguage,
      'TimeZoneId': instance.TimeZoneId,
    };
