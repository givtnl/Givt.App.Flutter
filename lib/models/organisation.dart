import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
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

  void organisationDetails(Map<String, dynamic> json) {
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

  void setMediumId(String id) {
    mediumId = id;
    notifyListeners();
  }

  Map<String, dynamic> toJson() => _$OrganisationToJson(this);
}
