import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/permission_models.dart';

//Permission.camera.status --> will return current status
//undetermined, granted, denied, restricted, permanentlyDenied

class CameraService extends ChangeNotifier {
  /// this gets overriden when the app launches and initiates state in main
  CameraSelection _cameraSelection = CameraSelection.noCameraPermission;

  CameraSelection get cameraSelection => _cameraSelection;

  set cameraSelection(CameraSelection value) {
    if (value != _cameraSelection) {
      _cameraSelection = value;
      notifyListeners();
    }
  }

  /// This only checks the permission status
  Future<bool> determineStatus() async {
    PermissionStatus result;
    result = await Permission.camera.status;
    if (result.isGranted) {
      cameraSelection = CameraSelection.yesCameraAccess;
      return true;
    } else if (Platform.isIOS || result.isPermanentlyDenied) {
      //Ios only allows to check permissions once
      cameraSelection = CameraSelection.noCameraPermissionPermanent;
    } else {
      // only executes on android
      cameraSelection = CameraSelection.noCameraPermission;
    }
    return false;
  }

  /// This opens up the native permissions dialogue and updates accordingly
  Future<bool> requestCameraPermission() async {
    PermissionStatus result;
    result = await Permission.camera.request();
    if (result.isGranted) {
      cameraSelection = CameraSelection.yesCameraAccess;
      return true;
    } else if (Platform.isIOS || result.isPermanentlyDenied) {
      //Ios only allows to check permissions once
      cameraSelection = CameraSelection.noCameraPermissionPermanent;
    } else {
      // only executes on android
      cameraSelection = CameraSelection.noCameraPermission;
    }
    return false;
  }
}
