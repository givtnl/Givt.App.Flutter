import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/models/permission_models.dart';
import 'package:givt_mobile_apps/models/progress.dart';
import 'package:provider/provider.dart';

import '../../../providers/camera_permission.dart';
import '../widgets/camera_permissions_check.dart';
import 'location_permission_page.dart';

class CameraPermissionPage extends StatefulWidget {
  const CameraPermissionPage({super.key});

  @override
  State<CameraPermissionPage> createState() => _CameraPermissionPageState();
}

class _CameraPermissionPageState extends State<CameraPermissionPage>
    with WidgetsBindingObserver {
  late final CameraController _controller;
  bool _detectPermission = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _controller = CameraController();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // This block of code is used in the event that the user
  // has denied the permission forever. Detects if the permission
  // has been granted when the user returns from the
  // permission system screen.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed &&
        _detectPermission &&
        (_controller.cameraSelection ==
            CameraSelection.noCameraPermissionPermanent)) {
      _detectPermission = false;
      _controller.requestCameraPermission();
    } else if (state == AppLifecycleState.paused &&
        _controller.cameraSelection ==
            CameraSelection.noCameraPermissionPermanent) {
      _detectPermission = true;
    }
  }

  /// Request permission
  /// Navigate to next page once the user decided
  /// Regardless of decision
  Future<void> _checkPermissions() async {
    /// await returns a bool but since we arent changing the UI based
    /// on the response then its unused.
    await _controller.requestCameraPermission();
  }

  @override
  Widget build(BuildContext context) {
    var progressModel = context.read<OnboardingProgressModel>();
    OnboardingProgress current =
        progressModel.realm.all<OnboardingProgress>().first;
    //because the user has landed on this page, it was asked.
    current.cameraAsked = true;
    return ChangeNotifierProvider.value(
      value: _controller,
      child: Consumer<CameraController>(
        builder: (context, model, child) {
          Widget widget;

// this switch statement might be redundant in the current flow
          switch (model.cameraSelection) {
            case CameraSelection.noCameraPermission:
              widget = CameraPermissionsCheck(
                  //isPermanent: false,
                  onPressed: () {
                _checkPermissions();
                Navigator.pushNamed(context, '/registration');
              });
              break;
            case CameraSelection.noCameraPermissionPermanent:
              widget = CameraPermissionsCheck(
                  //isPermanent: true,
                  onPressed: () {
                _checkPermissions();
                Navigator.pushNamed(context, '/registration');
              });
              break;
            case CameraSelection.yesCameraAccess:

              /// this will get executed if the permissions were
              /// approved from settings and the user returns to app
              widget = const LocationPermissionPage();
              break;
          }
          return widget;
        },
      ),
    );
  }
}
