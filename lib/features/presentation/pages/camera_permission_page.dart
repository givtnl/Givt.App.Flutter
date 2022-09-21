import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/constants/palette.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:givt_mobile_apps/features/presentation/components/core/buttons/button_bar_basic.dart';
import 'package:givt_mobile_apps/features/presentation/pages/location_permission_page.dart';
import 'package:givt_mobile_apps/features/presentation/pages/home_page.dart';
import 'package:provider/provider.dart';

import '../../models/camera_permission_model.dart';

class CameraPermissionPage extends StatefulWidget {
  const CameraPermissionPage({super.key});

  @override
  State<CameraPermissionPage> createState() => _CameraPermissionPageState();
}

class _CameraPermissionPageState extends State<CameraPermissionPage>
    with WidgetsBindingObserver {
  late final CameraModel _model;
  bool _detectPermission = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _model = CameraModel();
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
        (_model.cameraSelection ==
            CameraSelection.noCameraPermissionPermanent)) {
      _detectPermission = false;
      _model.requestCameraPermission();
    } else if (state == AppLifecycleState.paused &&
        _model.cameraSelection == CameraSelection.noCameraPermissionPermanent) {
      _detectPermission = true;
    }
  }

// this the UI and the place for ChangeNotifier
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _model,
      child: Consumer<CameraModel>(
        builder: (context, model, child) {
          Widget widget;

          switch (model.cameraSelection) {
            case CameraSelection.noCameraPermission:
              widget = CameraPermissions(
                  isPermanent: false, onPressed: _checkPermissions);
              break;
            case CameraSelection.noCameraPermissionPermanent:
              widget = CameraPermissions(
                  isPermanent: true, onPressed: _checkPermissions);
              break;
            case CameraSelection.yesCameraAccess:
              // TODO: Navigate to next screen
              widget = CameraAccepted();
              break;
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Handle permissions'),
            ),
            body: widget,
          );
        },
      ),
    );
  }

  /// Check if permission is granted,
  /// if it's not granted then request it.
  /// If it's granted then nothing happens hhah
  Future<void> _checkPermissions() async {
    final hasCameraPermission = await _model.requestCameraPermission();
    if (hasCameraPermission) {
      // i think the navigation should happen here
    }
  }
}

class CameraPermissions extends StatelessWidget {
  final bool isPermanent;
  final VoidCallback onPressed;
  const CameraPermissions({
    required this.isPermanent,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: SvgPicture.asset(
              'assets/svg/logo.svg',
              height: 22,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Allow Givt to access your camera so you can scan QR codes.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Palette.darkBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Only enabled while you use the app.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Palette.darkGrey,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Image.asset('assets/images/camera.png'),
                ),
              ],
            ),
          ),
          //const SizedBox(height: 45),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                child: BarButtonBasic(
                  title: 'Enable Camera',
                  where: LocationPermissionPage(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'continue using the app without the permission',
                    style: TextStyle(
                      color: Palette.darkBlue,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                      decorationThickness: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CameraAccepted extends StatelessWidget {
  const CameraAccepted({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Hey you did it!');
  }
}
