import 'package:get_it/get_it.dart';
import 'package:givt_mobile_apps/services/camera_service.dart';
import 'package:givt_mobile_apps/services/location_service.dart';
import '../models/localStorage.dart';
import '../services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => LocalStorageProxy());
  locator.registerLazySingleton(() => CameraService());
  locator.registerLazySingleton(() => LocationService());
}
