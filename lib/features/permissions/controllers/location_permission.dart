import 'package:givt_mobile_apps/models/local_storage.dart';
import 'package:givt_mobile_apps/services/local_storage_service.dart';

import 'package:givt_mobile_apps/services/location_service.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

class LocationController {
  late final LocalStorage current =
      locator<LocalStorageProxy>().realm.all<LocalStorage>().first;
  final NavigationService _navigationService = locator<NavigationService>();
  final LocationService _locationService = locator<LocationService>();

  Future<void> checkPermissions() async {
    /// await returns a bool but since we arent changing the UI based
    /// on the response then its unused.
    await _locationService.requestLocationPermission();

    _navigationService.navigateTo(routes.CameraPermissionRoute);
  }
}
