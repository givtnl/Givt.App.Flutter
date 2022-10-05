import 'package:get_it/get_it.dart';
import 'package:givt_mobile_apps/providers/camera_permission.dart';
import 'package:givt_mobile_apps/providers/location_permission.dart';
import '../models/progress.dart';
import '../services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => OnboardingProgressModel());
  locator.registerLazySingleton(() => CameraService());
  locator.registerLazySingleton(() => LocationService());
}
