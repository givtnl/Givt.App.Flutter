import 'package:givt_mobile_apps/models/progress.dart';

getRoute(OnboardingProgress current) {
  String route = '';
  if (current.cameraAsked) {
    route = 'registration';
  } else {
    route = 'camera-permission';
  }
  return route;
}
