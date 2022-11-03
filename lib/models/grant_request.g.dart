// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grant_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrantRequest _$GrantRequestFromJson(Map<String, dynamic> json) => GrantRequest(
      grantType: json['grant_type'] as String,
      userName: json['userName'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$GrantRequestToJson(GrantRequest instance) =>
    <String, dynamic>{
      'grant_type': instance.grantType,
      'userName': instance.userName,
      'password': instance.password,
    };
