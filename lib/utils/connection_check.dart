import 'dart:io';

Future<bool> tryConnection() async {
  bool isConnectionSuccessful;
  try {
    final response = await InternetAddress.lookup('www.google.com');

    isConnectionSuccessful = response.isNotEmpty;
    print('yes connection exists');
  } on SocketException catch (e) {
    print(e);
    isConnectionSuccessful = false;
  }
  return isConnectionSuccessful;
}
