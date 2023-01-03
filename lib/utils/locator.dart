import 'package:get_it/get_it.dart';
import 'package:givt_mobile_apps/services/api_service.dart';
import 'package:givt_mobile_apps/services/camera_service.dart';
import 'package:givt_mobile_apps/services/local_donation_service.dart';
import 'package:givt_mobile_apps/services/local_storage_service.dart';
import 'package:givt_mobile_apps/services/local_user_service.dart';
import 'package:givt_mobile_apps/services/location_service.dart';
import 'package:givt_mobile_apps/services/persistent_state_service.dart';
import 'package:givt_mobile_apps/services/user_service.dart';
import '../services/local_child_service.dart';
import '../services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => LocalStorageBase());
  locator.registerLazySingleton(() => PersistentStateService());
  locator.registerLazySingleton(() => LocalDonationService());
  locator.registerLazySingleton(() => LocalChildUserService());
  locator.registerLazySingleton(() => LocalUserService());
  locator.registerLazySingleton(() => CameraService());
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => APIService());
}
