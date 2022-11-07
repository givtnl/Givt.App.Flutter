import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../core/constants/environment_variables.dart';

class APIService {
  Map<String, String> get headers => {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

  Future<bool> checktld(String email) async {
    final url = Uri.https(baseApiUrl, '/api/checktld', {'email': email});
    final response = await http.get(url);
    return (response.statusCode >= 400) ? false : true;
  }

  Future<String> createTempUser(String jsonUser) async {
    final url = Uri.https(baseApiUrl, '/api/v2/users');
    var response = await http.post(url, body: jsonUser, headers: headers);
    // response.body is plain text of the user ID or an error
    if (response.statusCode >= 400) {
      throw HttpException(response.body);
    } else {
      return response.body;
    }
  }

  Future<dynamic> createRegisteredUser(String jsonUser) async {
    final url = Uri.https(baseApiUrl, '/api/v2/users/register');
    var response = await http.post(url, body: jsonUser, headers: headers);
    if (response.statusCode >= 400) {
      throw Exception('Failed to create a registered user');
    } else {
      // returns stringified object
      return response.body;
    }
  }

  Future<dynamic> updateUser(String jsonUser) async {
    final url = Uri.https(baseApiUrl, '/api/v2/users');
    var response = await http.put(url, body: jsonUser, headers: headers);
    if (response.statusCode >= 400) {
      throw Exception('Failed to update a user');
    } else {
      return response.body;
    }
  }

  Future<dynamic> createMandate(String wepayToken, String userId) async {
    final url = Uri.https(baseApiUrl, '/api/v2/users/$userId/mandates');
    final String mandate = json.encode({
      'paymentMethodToken': wepayToken,
      'userId': userId,
    });
    var response = await http.post(url, body: mandate, headers: headers);
    if (response.statusCode >= 400) {
      throw Exception('Failed to create a mandate for user: $userId.');
    } else {
      // returns stringified object
      return response.body;
    }
  }

  Future<dynamic> submitDonation(String userId, String donationObject) async {
    final url = Uri.https(baseApiUrl, '/api/v2/users/$userId/givts');
    var response = await http.post(url, body: donationObject, headers: headers);
    if (response.statusCode >= 400) {
      throw Exception('Failed to process donation');
    } else {
      // returns stringified object
      return response.body;
    }
  }

  Future<dynamic> checkEmailExists(String email) async {
    final url = Uri.https(baseApiUrl, '/api/v2/Users/check', {'email': email});
    var response = await http.get(url, headers: headers);
    if (response.statusCode >= 400) {
      throw Exception('something went wrong :(');
    } else {
      return response.body;
    }
  }

  Future<dynamic> getOrganisationDetailsFromMedium(String mediumCode) async {
    final url = Uri.https(
        baseApiUrl, '/api/v2/CollectGroups/medium', {'Code': mediumCode});
    var response = await http.get(url, headers: headers);
    if (response.statusCode >= 400) {
      throw Exception('something went wrong :(');
    } else {
      return response.body;
    }
  }
}
