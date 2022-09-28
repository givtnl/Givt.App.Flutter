import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/templates/base_template.dart';
import 'package:givt_mobile_apps/core/widgets/buttons/bypass_button.dart';
import 'package:givt_mobile_apps/models/permission_models.dart';
import 'package:givt_mobile_apps/models/progress.dart';
import 'package:givt_mobile_apps/features/registration/pages/first_time_registration_page.dart';
import 'package:provider/provider.dart';
import '../widgets/loctaion_permission_check.dart';

import '../../../providers/location_permission.dart';

class LocationPermissionPage extends StatefulWidget {
  const LocationPermissionPage({super.key});

  @override
  State<LocationPermissionPage> createState() => _LocationPermissionPageState();
}

class _LocationPermissionPageState extends State<LocationPermissionPage>
    with WidgetsBindingObserver {
  late final LocationController _controller;
  bool _detectPermission = false;
  OnboardingProgressModel? progressModel;
  String where = '/';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    progressModel = context.read<OnboardingProgressModel>();
    OnboardingProgress current =
        progressModel!.realm.all<OnboardingProgress>().first;
    //because the user has landed on this page, it was asked.
    progressModel!.realm.write(() {
      OnboardingProgress localCurrent =
          progressModel!.realm.all<OnboardingProgress>().first;
      localCurrent.locationAsked = true;

      if (current.cameraAsked) {
        where = '/registration';
      } else {
        where = '/camera-permission';
      }
    });

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
            where: where),
        onBtnClick: () {
          _checkPermissions();
          Navigator.pushNamed(context, where);
        },
        title: 'Enable Location',
        isBtnDisabled: false);
  }
}
