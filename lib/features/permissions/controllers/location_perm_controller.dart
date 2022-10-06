import 'package:givt_mobile_apps/models/progress.dart';
import 'package:givt_mobile_apps/services/location_service.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

class LocationController {
  late final OnboardingProgress current =
      locator<OnboardingProgressModel>().realm.all<OnboardingProgress>().first;
  final NavigationService _navigationService = locator<NavigationService>();
  final LocationService _locationService = locator<LocationService>();

  getRoute() {
    dynamic route;
    if (current.cameraAsked) {
      route = routes.RegistrationRoute;
    } else {
      route = routes.CameraPermissionRoute;
    }
    return route;
  }

  Future<void> checkPermissions() async {
    /// await returns a bool but since we arent changing the UI based
    /// on the response then its unused.
    await _locationService.requestLocationPermission();
    if (current.cameraAsked) {
      _navigationService.navigateTo(routes.RegistrationRoute);
    } else {
      _navigationService.navigateTo(routes.CameraPermissionRoute);
    }
  }
}
