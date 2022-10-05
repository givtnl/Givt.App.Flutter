import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/permission_models.dart';

class LocationService extends ChangeNotifier {
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

  Future<bool> determineStatus() async {
    PermissionStatus result;
    result = await Permission.location.status;
    if (result.isGranted) {
      locationSelection = LocationSelection.yesLocationAccess;
      return true;
    } else if (Platform.isIOS || result.isPermanentlyDenied) {
      //Ios only allows to check permissions once
      locationSelection = LocationSelection.noLocationPermissionPermanent;
    } else {
      // only executes on android
      locationSelection = LocationSelection.noLocationPermission;
    }
    return false;
  }

  /// Request the files permission and updates the UI accordingly
  Future<bool> requestLocationPermission() async {
    PermissionStatus result;
    result = await Permission.location.request();
    if (result.isGranted) {
      locationSelection = LocationSelection.yesLocationAccess;
      print('succes, location permission is ${result}');
      return true;
    } else if (Platform.isIOS || result.isPermanentlyDenied) {
      //Ios only allows to check permissions once
      locationSelection = LocationSelection.noLocationPermissionPermanent;
      print('oh no, location permission is: ${result}, gotta go open settings');
    } else {
      // only executes on android
      locationSelection = LocationSelection.noLocationPermission;
      print('oh bummer, location permission is: ${result}, try again?');
    }
    return false;
  }
}
