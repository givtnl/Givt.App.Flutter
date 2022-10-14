import 'package:givt_mobile_apps/models/localStorage.dart';
import 'package:givt_mobile_apps/services/camera_service.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

class CameraController {
  late final LocalStorage current =
      locator<LocalStorageProxy>().realm.all<LocalStorage>().first;
  final NavigationService _navigationService = locator<NavigationService>();
  final CameraService _cameraService = locator<CameraService>();

  Future<void> checkPermissions() async {
    /// await returns a bool but since we arent changing the UI based
    /// on the response then its unused.
    await _cameraService.requestCameraPermission();
    _navigationService.navigateTo(routes.RegistrationRoute);
  }
}
