import 'package:givt_mobile_apps/models/localStorage.dart';

import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

void checkProgressAndNavigate() {
  final NavigationService _navigationService = locator<NavigationService>();

  final LocalStorageProxy _model = locator<LocalStorageProxy>();
  LocalStorage current = _model.realm.all<LocalStorage>().first;

  if (!current.locationAsked && !current.cameraAsked) {
    _navigationService.navigateTo(routes.LocationPermissionRoute);
  } else if (current.locationAsked && !current.cameraAsked) {
    _navigationService.navigateTo(routes.CameraPermissionRoute);
  } else if (current.locationAsked && current.cameraAsked) {
    _navigationService.navigateTo(routes.RegistrationRoute);
  }
}