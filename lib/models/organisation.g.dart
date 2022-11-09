// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organisation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Organisation _$OrganisationFromJson(Map<String, dynamic> json) => Organisation(
      json['organisationName'] as String?,
      json['country'] as String?,
      json['organisationLogoLink'] as String?,
      json['title'] as String?,
      json['goal'] as String?,
      json['thankYou'] as String?,
      json['paymentMethods'] as List<dynamic>?,
      json['currency'] as String?,
      json['amounts'] as List<dynamic>?,
      json['wantKnowMoreLink'] as String?,
      json['privacyPolicyLink'] as String?,
      json['mediumId'] as String?,
    );

Map<String, dynamic> _$OrganisationToJson(Organisation instance) =>
    <String, dynamic>{
      'organisationName': instance.organisationName,
      'country': instance.country,
      'organisationLogoLink': instance.organisationLogoLink,
      'title': instance.title,
      'goal': instance.goal,
      'thankYou': instance.thankYou,
      'paymentMethods': instance.paymentMethods,
      'currency': instance.currency,
      'amounts': instance.amounts,
      'wantKnowMoreLink': instance.wantKnowMoreLink,
      'privacyPolicyLink': instance.privacyPolicyLink,
      'mediumId': instance.mediumId,
    };
