import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/templates/base_template.dart';
import 'package:givt_mobile_apps/core/widgets/buttons/bypass_button.dart';
import 'package:givt_mobile_apps/features/permissions/controllers/camera_perm_controller.dart';
import 'package:givt_mobile_apps/models/localStorage.dart';
import 'package:givt_mobile_apps/models/permission_models.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/route_paths.dart' as routes;

import '../../../services/camera_service.dart';
import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';

class CameraPermissionPage extends StatefulWidget {
  const CameraPermissionPage({super.key});

  @override
  State<CameraPermissionPage> createState() => _CameraPermissionPageState();
}

class _CameraPermissionPageState extends State<CameraPermissionPage>
    with WidgetsBindingObserver {
  final LocalStorageProxy _model = locator<LocalStorageProxy>();
  final CameraService _cameraService = locator<CameraService>();
  final _cameraController = CameraController();
  bool _detectPermission = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _model.updateProgress('camera');
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
        (_cameraService.cameraSelection ==
            CameraSelection.noCameraPermissionPermanent)) {
      _detectPermission = false;
      _cameraService.requestCameraPermission();
    } else if (state == AppLifecycleState.paused &&
        _cameraService.cameraSelection ==
            CameraSelection.noCameraPermissionPermanent) {
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
              'Allow Givt to access your camera so you can scan QR codes.',
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
              child: Image.asset('assets/images/camera.png'),
            ),
          ],
        ),
      ),
      bypassBtn: BypassBtn(
          title: 'continue using the app without the permission',
          where: routes.QRMockRoute),
      onBtnClick: () {
        _cameraController.checkPermissions();
      },
      title: 'Enable Location',
      isBtnDisabled: false,
    );
  }
}
