import 'package:flutter/material.dart';

import 'package:realm/realm.dart';

// Realm: Declare a part file
part 'progress.g.dart';

// Realm: Creating a Realm object data model class
@RealmModel()
class _OnboardingProgress {
  bool locationAsked = false;
  bool cameraAsked = false;
  bool emailRegistered = false;
  _OnboardedUser? user;
}

@RealmModel()
class _OnboardedUser {
  late String email;
}

/// A proxy of the data
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
}
