import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class CheckInternet extends ChangeNotifier {
  bool hasInternet = true;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;
  Future<void> checkInitialConnection() async {
    final status = await _connectivity.checkConnectivity();
    if (status == ConnectivityResult.none) {
      hasInternet = false;
      notifyListeners();
    } else {
      hasInternet = true;
      notifyListeners();
    }
  }

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
