import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:givt_mobile_apps/models/temp_user.dart';
import 'package:givt_mobile_apps/services/local_storage_service.dart';
import 'package:givt_mobile_apps/utils/api_service_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';
import '../models/local_storage.dart';
import '../models/registered_user.dart';
import '../utils/locator.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

/// [ApiService] is a wrapper around the [Client]
class APIService {
  Client client = InterceptedClient.build(
    interceptors: [
      GivtApiInterceptor(),
    ],
    retryPolicy: ExpiredTokenRetryPolicy(),
  );

  late final LocalStorageBase storageProxy = locator<LocalStorageBase>();
  String apiURL =
      kReleaseMode ? 'api.givt.app' : 'givt-debug-api.azurewebsites.net';
  APIService() {
    logger.wtf('api url is ${apiURL}');
  }

  Future<bool> checktld(String email) async {
    final url = Uri.https(apiURL, '/api/checktld', {'email': email});
    final response = await client.get(url);
    return (response.statusCode >= 400) ? false : true;
  }

  Future<String> createTempUser(TempUser user) async {
    final encodedUser = jsonEncode(user);
    final url = Uri.https(apiURL, '/api/v2/users');
    var response = await client.post(url, body: encodedUser);
    // response.body is plain text of the user ID or an error
    if (response.statusCode >= 400) {
      throw HttpException(response.body);
    } else {
      return response.body;
    }
  }

  Future<dynamic> createRegisteredUser(RegisteredUser user) async {
    final encodedUser = jsonEncode(user);
    final url = Uri.https(apiURL, '/api/v2/users/register');
    var response = await client.post(url, body: encodedUser);
    if (response.statusCode >= 400) {
      throw Exception('Failed to create a registered user');
    } else {
      // returns stringified object
      return response.body;
    }
  }

  Future<dynamic> createMandate(String wepayToken, String userId) async {
    final url = Uri.https(apiURL, '/api/v2/users/$userId/mandates');
    final String mandate = json.encode({
      'paymentMethodToken': wepayToken,
      'userId': userId,
    });
    var response = await client.post(url, body: mandate);
    if (response.statusCode >= 400) {
      throw Exception('Failed to create a mandate for user: $userId.');
    } else {
      // returns stringified object
      return response.body;
    }
  }

  Future<dynamic> submitDonation(String userId, String wepayToken) async {
    final encodedDonation = getEncodedDonation(wepayToken);
    final url = Uri.https(apiURL, '/api/v2/users/$userId/givts');
    var response = await client.post(url, body: encodedDonation);
    if (response.statusCode >= 400) {
      throw Exception('Failed to process donation');
    } else {
      // returns stringified object
      return response.body;
    }
  }

  // encode into JSON using temp data
  String getEncodedDonation(wepayToken) {
    LocalUser localUser =
        storageProxy.realm.all<LocalStorage>().first.userData!;
    Donation? localDonation = storageProxy.realm
        .all<LocalStorage>()
        .first
        .donations
        .firstWhere((element) => element.guid == localUser.userId);

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

  Future<dynamic> checkEmailExists(String email) async {
    final url = Uri.https(apiURL, '/api/v2/Users/check', {'email': email});
    var response = await client.get(url);
    if (response.statusCode >= 400) {
      throw Exception('Failed to check email');
    } else {
      return response.body;
    }
  }

  Future<dynamic> login(Map loginCredentials) async {
    final url = Uri.https(apiURL, '/api/Givts',
        {'UserId': '698c3dcf-8083-49e3-a80d-d6591d0a41c7'});
    // might need to use api/v2/users/login
    var response = await client.get(
      url,
      // body: loginCredentials,
    );
    if (response.statusCode >= 400) {
      throw Exception(jsonDecode(response.body));
    } else {
      return response.body;
    }
  }

  Future<dynamic> getOrganisationDetailsFromMedium(String mediumCode) async {
    final url = Uri.https(apiURL, '/api/v3/campaigns', {'code': mediumCode});
    var response = await client.get(url);
    if (response.statusCode >= 400) {
      throw Exception('something went wrong :(');
    } else {
      return response.body;
    }
  }

  /// Returns the new access token with a new refresh_token
  Future<dynamic> refreshToken(String refreshToken) async {
    final url = Uri.https(apiURL, '/oauth2/token');
    var response = await client.post(url, body: {
      'grant_type': 'refresh_token',
      'refresh_token': refreshToken,
    });
    if (response.statusCode >= 400) {
      throw Exception('something went wrong :(');
    } else {
      return response.body;
    }
  }
}
