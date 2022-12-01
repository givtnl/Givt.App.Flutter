import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/templates/base_template.dart';
import 'package:givt_mobile_apps/core/widgets/buttons/bypass_button.dart';
import 'package:givt_mobile_apps/features/permissions/controllers/location_permission.dart';
import 'package:givt_mobile_apps/models/permission_models.dart';
import 'package:givt_mobile_apps/services/location_service.dart';
import '../../../core/constants/route_paths.dart' as routes;

import '../../../utils/locator.dart';

class LocationPermissionPage extends StatefulWidget {
  const LocationPermissionPage({super.key});

  @override
  State<LocationPermissionPage> createState() => _LocationPermissionPageState();
}

class _LocationPermissionPageState extends State<LocationPermissionPage>
    with WidgetsBindingObserver {
  final LocationService _locationService = locator<LocationService>();
  final _locationController = LocationController();
  bool _detectPermission = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
        (_locationService.locationSelection ==
            LocationSelection.noLocationPermissionPermanent)) {
      _detectPermission = false;
      _locationService.requestLocationPermission();
    } else if (state == AppLifecycleState.paused &&
        _locationService.locationSelection ==
            LocationSelection.noLocationPermissionPermanent) {
      _detectPermission = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
        pageContent: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Allow Givt to access your location to know when you are in church.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1?.color,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'Only enabled while you use the app.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2?.color,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Image.asset('assets/images/location_map.png'),
              ),
            ],
          ),
        ),
        bypassBtn: BypassBtn(
          title: 'continue using the app without the permission',
          where: routes.CameraPermissionRoute,
        ),
        onBtnClick: () {
          _locationController.checkPermissions();
        },
        title: 'Let\'s do it',
        isBtnDisabled: false);
  }
}
