import 'package:flutter/material.dart';

import 'package:realm/realm.dart';

// Realm: Declare a part file
part 'progress.g.dart';

// Realm: Creating a Realm object data model class
// this defines a schema, needs thinking
@RealmModel()
class _OnboardingProgress {
  bool locationAsked = false;
  bool cameraAsked = false;
  bool emailRegistered = false;
  _OnboardedUser? user;
}

@RealmModel()
class _OnboardedUser {
  // could store more data
  late String email;
}

/// A proxy of the data
/// should this be a separate file? i like it here but maybeee
class OnboardingProgressModel {
  late Realm realm;

  OnboardingProgressModel() {
    var config =
        Configuration.local([OnboardingProgress.schema, OnboardedUser.schema]);
    realm = Realm(config);

    if (realm.all<OnboardingProgress>().isEmpty) {
      realm.write(() => realm.add(OnboardingProgress(
            locationAsked: false,
            cameraAsked: false,
            emailRegistered: false,
          )));
    }
  }
  void updateProgress(String key) {
    realm.write(() {
      if (key == 'camera') {
        OnboardingProgress localCurrent = realm.all<OnboardingProgress>().first;
        localCurrent.cameraAsked = true;
      }
      if (key == 'loctation') {
        OnboardingProgress localCurrent = realm.all<OnboardingProgress>().first;
        localCurrent.locationAsked = true;
      }
    });
  }
}
