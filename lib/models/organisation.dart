import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../services/api_service.dart';
import '../utils/locator.dart';
part 'organisation.g.dart';

@JsonSerializable()
class Organisation extends ChangeNotifier {
  String? organisationName;
  String? country;
  String? organisationLogoLink;
  String? title;
  String? goal;
  String? thankYou;
  List<dynamic>? paymentMethods;
  String? currency;
  List<dynamic>? amounts;
  String? wantKnowMoreLink;
  String? privacyPolicyLink;
  String? mediumId;

  Organisation(
      [this.organisationName,
      this.country,
      this.organisationLogoLink,
      this.title,
      this.goal,
      this.thankYou,
      this.paymentMethods,
      this.currency,
      this.amounts,
      this.wantKnowMoreLink,
      this.privacyPolicyLink,
      this.mediumId]);
  final apiService = locator<APIService>();

  void setOrganisationDetails(Map<String, dynamic> json) {
    organisationName = json['organisationName'];
    country = json['country'];
    organisationLogoLink = json['organisationLogoLink'];
    title = json['title'];
    goal = json['goal'];
    thankYou = json['thankYou'];
    paymentMethods = json['paymentMethods'];
    currency = json['currency'];
    amounts = json['amounts'];
    wantKnowMoreLink = json['wantKnowMoreLink'];
    privacyPolicyLink = json['privacyPolicyLink'];
    notifyListeners();
  }

  void setMediumId(String base64MediumId) {
    mediumId = utf8.decode(base64.decode(base64MediumId));
    notifyListeners();
  }

  Future<bool> setOrganisationFromScannedCode(String code) async {
    try {
      final uri = Uri.parse(code);
      final mediumId = uri.queryParameters['code'];
      final response =
          await apiService.getOrganisationDetailsFromMedium(mediumId!);

      Map<String, dynamic> decoded = json.decode(response);
      setOrganisationDetails(decoded);
      setMediumId(mediumId);
      return true;
    } catch (error) {
      return false;
    }
  }

  Map<String, dynamic> toJson() => _$OrganisationToJson(this);
}
