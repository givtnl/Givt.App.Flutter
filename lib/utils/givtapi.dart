import 'package:http/http.dart' as http;
import '../core/constants/environment_variables.dart';

class GivtAPI {
  Future<bool> checktld(String email) async {
    final url = Uri.https(baseApiUrl, '/api/checktld', {'email': email});
    final response = await http.get(url);
    return (response.statusCode == 200) ? true : false;
  }

  Future createUser(String jsonUser) async {
    final url = Uri.https(baseApiUrl, '/api/v2/users');
    return await http.post(url, body: jsonUser);
  }
}
