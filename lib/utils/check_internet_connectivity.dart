import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class CheckInternet extends ChangeNotifier {
  bool hasInternet = true;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;

  void checkRealtimeConnection() {
    _streamSubscription = _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none) {
        hasInternet = false;
        notifyListeners();
      } else {
        hasInternet = true;
        notifyListeners();
      }
    });
  }
}
