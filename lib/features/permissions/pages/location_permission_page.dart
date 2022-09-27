import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/features/benefits/usp.dart';
import 'package:provider/provider.dart';
import 'package:givt_mobile_apps/core/constants/palette.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:givt_mobile_apps/core/widgets/buttons/button_bar_basic.dart';
import '../widgets/loctaion_permission_check.dart';

import '../controller/location_permission_controller.dart';

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
    //_checkPermissions(context, UspPage());
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
  Future<void> _checkPermissions(context, where) async {
    await _controller.requestLocationPermission();

    /// await returns a bool but since we arent changing the UI based
    /// on the response then its unused.
    Navigator.pushNamed(context, where);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _controller,
      child: Consumer<LocationController>(
        builder: (context, model, child) {
          Widget widget;

          switch (model.locationSelection) {
            case LocationSelection.noLocationPermission:
              widget = LocationPermissionsCheck(
                  //isPermanent: false,
                  onPressed: () => _checkPermissions(context, '/usp'));
              break;
            case LocationSelection.noLocationPermissionPermanent:
              widget = LocationPermissionsCheck(
                  //isPermanent: true,
                  onPressed: () => _checkPermissions(context, '/usp'));
              break;
            case LocationSelection.yesLocationAccess:

              /// this will get executed if the permissions were
              /// approved from settings and the user returns to app
              widget = const UspPage();
              break;
          }
          return widget;
        },
      ),
    );
  }
}
