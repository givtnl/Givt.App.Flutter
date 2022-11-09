import 'dart:convert';
import 'package:givt_mobile_apps/models/localStorage.dart';
import 'package:givt_mobile_apps/utils/locator.dart';

class Donation {
  late final LocalStorageProxy storageProxy = locator<LocalStorageProxy>();
  final String wepayToken;

  Donation({
    required this.wepayToken,
  });

  // encode into JSON using temp data
  String jsonDonation() {
    LocalUser localUser =
        storageProxy.realm.all<LocalStorage>().first.userData!;
    Donations? localDonation = storageProxy.realm
        .all<LocalStorage>()
        .first
        .donations
        .firstWhere((element) => element.userId == localUser.userId);

    return jsonEncode({
      "donations": [
        {
          "userId": localUser.userId,
          "amount": localDonation.donationAmount,
          "collectId": 1,
          "mediumId": localDonation.mediumId,
          "timestamp": localDonation.dateTime
        }
      ],
      "wePayPaymentDetails": {
        "zipCode": localUser.postalCode,
        "paymentMethodToken": wepayToken
      },
      "donationType": 0
    });
  }
}
