import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

// This enum will manage the overall state
enum CameraSelection {
  noCameraPermission, // Permission denied, but not forever
  noCameraPermissionPermanent, // Permission denied forever
  yesCameraAccess //Yay
}

//Permission.camera.status --> will return current status
//undetermined, granted, denied, restricted, permanentlyDenied

class CameraModel extends ChangeNotifier {
  /// this does not get remebered/ overriden  if app is restarted
  /// need some sort of localStorage
  CameraSelection _cameraSelection = CameraSelection.noCameraPermission;

  CameraSelection get cameraSelection => _cameraSelection;

  set cameraSelection(CameraSelection value) {
    if (value != _cameraSelection) {
      _cameraSelection = value;
      notifyListeners();
    }
  }

  /// Request the files permission and updates the UI accordingly
  Future<bool> requestCameraPermission() async {
    PermissionStatus result;
    result = await Permission.camera.request();
    if (result.isGranted) {
      cameraSelection = CameraSelection.yesCameraAccess;
      print('succes, the result is: ${result}');
      return true;
    } else if (Platform.isIOS || result.isPermanentlyDenied) {
      //Ios only allows to check permissions once
      cameraSelection = CameraSelection.noCameraPermissionPermanent;
      print('oh no, the result is: ${result}, gotta go open settings');
    } else {
      // only executes on android
      cameraSelection = CameraSelection.noCameraPermission;
      print('oh bummer, the result is: ${result}, try again?');
    }
    return false;
  }
}
