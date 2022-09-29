import 'package:givt_mobile_apps/models/progress.dart';

// This is implemented as a method on the realm model, so unneccessary.
void updateProgress(OnboardingProgress progress, String key) {
  progress.realm.write(() {
    if (key == 'camera') {
      OnboardingProgress localCurrent =
          progress.realm.all<OnboardingProgress>().first;
      localCurrent.cameraAsked = true;
    }
    if (key == 'loctation') {
      OnboardingProgress localCurrent =
          progress.realm.all<OnboardingProgress>().first;
      localCurrent.locationAsked = true;
    }
  });
}
