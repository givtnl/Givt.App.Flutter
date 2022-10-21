import 'dart:io';

Future<bool> tryConnection() async {
  bool isConnectionSuccessful;
  try {
    final response = await InternetAddress.lookup('google.com');
    isConnectionSuccessful = response.isNotEmpty;
  } on SocketException catch (e) {
    print(e);
    isConnectionSuccessful = false;
  }
  return isConnectionSuccessful;
}
