import 'package:givt_mobile_apps/models/progress.dart';

import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

void checkProgressAndNavigate() {
  final NavigationService _navigationService = locator<NavigationService>();
  final OnboardingProgressModel _model = locator<OnboardingProgressModel>();

  OnboardingProgress current = _model.realm.all<OnboardingProgress>().first;

  if (!current.locationAsked && !current.cameraAsked) {
    _navigationService.navigateTo(routes.LocationPermissionRoute);
  } else if (current.locationAsked && !current.cameraAsked) {
    _navigationService.navigateTo(routes.CameraPermissionRoute);
  } else if (current.locationAsked && current.cameraAsked) {
    _navigationService.navigateTo(routes.RegistrationRoute);
  }
}
