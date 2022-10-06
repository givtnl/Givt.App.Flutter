import 'package:realm/realm.dart';

// Realm: Declare a part file
part 'localStorage.g.dart';

@RealmModel()
class _LocalUser {
  bool locationAsked = false;
  bool cameraAsked = false;
  // non_constant_identifier_names
  String? email;
  String? userId;
  String? iBAN;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? address;
  String? city;
  String? postalCode;
  String? country;
  //no password in local storage haha
  int? amountLimit;
  String? appLanguage;
  String? timeZoneId;
  _CachedGivts? cachedGivts;
}

@RealmModel()
class _CachedGivts {
  // could store more data
  late final String campaignId;
  late final int donationAmount;
  late final DateTime dateTime;
  late final String userId;
}

/// A proxy of the data
/// should this be a separate file? i like it here but maybeee
class LocalUserProxy {
  late Realm realm;

  LocalUserProxy() {
    var config = Configuration.local([LocalUser.schema, CachedGivts.schema]);
    realm = Realm(config);

    if (realm.all<LocalUser>().isEmpty) {
      realm.write(() => realm.add(LocalUser(
            locationAsked: false,
            cameraAsked: false,
          )));
    }
  }
  void updateProgress(String key) {
    realm.write(() {
      LocalUser localCurrent = realm.all<LocalUser>().first;
      if (key == 'camera') {
        localCurrent.cameraAsked = true;
      }
      if (key == 'location') {
        localCurrent.locationAsked = true;
      }
    });
  }

  // this is utility for resetting the flow
  void downgradeProgress(String key) {
    realm.write(() {
      LocalUser localCurrent = realm.all<LocalUser>().first;
      if (key == 'camera') {
        localCurrent.cameraAsked = false;
      }
      if (key == 'location') {
        localCurrent.locationAsked = false;
      }
    });
  }
}
