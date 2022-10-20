import 'dart:convert';

import 'package:givt_mobile_apps/models/temp-user.dart';

class Donation {
  final String userId;
  final String amount;
  final String timeStamp;
  final String collectId;
  final String mediumId;
  final String postalCode;
  final String wepayToken;

  Donation({
    required this.userId,
    required this.amount,
    required this.timeStamp,
    required this.collectId,
    required this.mediumId,
    required this.postalCode,
    required this.wepayToken,
  });

  // createTempDonationObj -- aggregates data from userID

  // encode into JSON using temp data
  String jsonDonation() {
    return jsonEncode({
      "donations": [
        {
          "userId": userId,
          "amount": amount,
          "collectId": 1,
          "mediumId": mediumId,
          "timestamp": timeStamp
        }
      ],
      "wePayPaymentDetails": {
        "zipCode": postalCode,
        "paymentMethodToken": wepayToken
      },
      "donationType": 0
    });
  }
}
