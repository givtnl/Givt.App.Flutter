// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registered_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisteredUser _$RegisteredUserFromJson(Map<String, dynamic> json) =>
    RegisteredUser(
      email: json['email'] as String,
      guid: json['userId'] as String,
      phoneNumber: json['phoneNumber'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      deviceOS: json['deviceOS'] as int,
      postalCode: json['postalCode'] as String,
      country: json['country'] as String,
      password: json['password'] as String,
      appLanguage: json['appLanguage'] as String,
      timeZoneId: json['timeZoneId'] as String,
    );

Map<String, dynamic> _$RegisteredUserToJson(RegisteredUser instance) =>
    <String, dynamic>{
      'userId': instance.guid,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'appLanguage': instance.appLanguage,
      'deviceOS': instance.deviceOS,
      'country': instance.country,
      'postalCode': instance.postalCode,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'timeZoneId': instance.timeZoneId,
    };
