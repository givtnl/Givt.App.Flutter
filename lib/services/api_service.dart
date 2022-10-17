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

  Future<String> createUser(String jsonUser) async {
    final url = Uri.https(baseApiUrl, '/api/v2/users');
    var response = await http.post(url, body: jsonUser, headers: headers);
    // response.body is plain text of the user ID or an error
    if (response.statusCode >= 400) {
      throw HttpException(response.body);
    } else {
      return response.body;
    }
  }
}
