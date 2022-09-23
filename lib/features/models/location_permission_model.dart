import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

// This enum will manage the overall state
enum LocationSelection {
  noLocationPermission, // Permission denied, but not forever
  noLocationPermissionPermanent, // Permission denied forever
  yesLocationAccess //Yay
}

//Permission.location.status --> will return current status
//undetermined, granted, denied, restricted, permanentlyDenied

class LocationModel extends ChangeNotifier {
  /// this does not get remebered/ overriden  if app is restarted
  /// so it should be determied we app opens instead of hardcoded here
  LocationSelection _locationSelection = LocationSelection.noLocationPermission;

  LocationSelection get locationSelection => _locationSelection;

  set locationSelection(LocationSelection value) {
    if (value != _locationSelection) {
      _locationSelection = value;
      notifyListeners();
    }
  }

  /// Request the files permission and updates the UI accordingly
  Future<bool> requestLocationPermission() async {
    PermissionStatus result;
    result = await Permission.location.request();
    if (result.isGranted) {
      locationSelection = LocationSelection.yesLocationAccess;
      print('succes, the result is: ${result}');
      return true;
    } else if (Platform.isIOS || result.isPermanentlyDenied) {
      //Ios only allows to check permissions once
      locationSelection = LocationSelection.noLocationPermissionPermanent;
      print('oh no, the result is: ${result}, gotta go open settings');
    } else {
      // only executes on android
      locationSelection = LocationSelection.noLocationPermission;
      print('oh bummer, the result is: ${result}, try again?');
    }
    return false;
  }
}
