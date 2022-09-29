import 'package:givt_mobile_apps/models/progress.dart';

checkProgress(OnboardingProgress current) {
  String route = '';
  if (!current.locationAsked && !current.cameraAsked) {
    route = '/location-permission';
  } else if (current.locationAsked && !current.cameraAsked) {
    route = '/camera-permission';
  } else if (current.locationAsked && current.cameraAsked) {
    route = '/registration';
  }
  return route;
}
