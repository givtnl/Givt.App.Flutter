import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/models/permission_models.dart';
import 'package:givt_mobile_apps/core/models/progress.dart';
import 'package:givt_mobile_apps/features/registration/pages/first_time_registration_page.dart';
import 'package:provider/provider.dart';
import '../widgets/loctaion_permission_check.dart';

import '../../../core/controllers/location_permission_controller.dart';

class LocationPermissionPage extends StatefulWidget {
  const LocationPermissionPage({super.key});

  @override
  State<LocationPermissionPage> createState() => _LocationPermissionPageState();
}

class _LocationPermissionPageState extends State<LocationPermissionPage>
    with WidgetsBindingObserver {
  late final LocationController _controller;
  bool _detectPermission = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _controller = LocationController();
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
        (_controller.locationSelection ==
            LocationSelection.noLocationPermissionPermanent)) {
      _detectPermission = false;
      _controller.requestLocationPermission();
    } else if (state == AppLifecycleState.paused &&
        _controller.locationSelection ==
            LocationSelection.noLocationPermissionPermanent) {
      _detectPermission = true;
    }
  }

  /// Request permission
  /// Navigate to next page once the user decided
  /// Regardless of decision
  Future<void> _checkPermissions() async {
    /// await returns a bool but since we arent changing the UI based
    /// on the response then its unused.
    await _controller.requestLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    var progressModel = context.read<OnboardingProgressModel>();
    OnboardingProgress current =
        progressModel.realm.all<OnboardingProgress>().first;
    //because the user has landed on this page, it was asked.
    current.locationAsked = true;
    return ChangeNotifierProvider.value(
      value: _controller,
      child: Consumer<LocationController>(
        builder: (context, model, child) {
          Widget widget;

// this switch statement might be redundant in the current flow
          switch (model.locationSelection) {
            case LocationSelection.noLocationPermission:
              widget = LocationPermissionsCheck(
                  //isPermanent: false,
                  onPressed: () {
                _checkPermissions();
                if (current.cameraAsked) {
                  Navigator.pushNamed(context, '/registration');
                } else {
                  Navigator.pushNamed(context, '/camera-permission');
                }
              });
              break;
            case LocationSelection.noLocationPermissionPermanent:
              widget = LocationPermissionsCheck(
                  //isPermanent: true,
                  onPressed: () {
                _checkPermissions();
                if (current.cameraAsked) {
                  Navigator.pushNamed(context, '/registration');
                } else {
                  Navigator.pushNamed(context, '/camera-permission');
                }
              });
              break;
            case LocationSelection.yesLocationAccess:

              /// this will get executed if the permissions were
              /// approved from settings and the user returns to app
              widget = const FirstTimeRegistrationPage();
              break;
          }
          return widget;
        },
      ),
    );
  }
}
