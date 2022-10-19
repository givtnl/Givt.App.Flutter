import 'package:realm/realm.dart';

// Realm: Declare a part file
part 'localStorage.g.dart';

@RealmModel()
class _LocalStorage {
  bool locationAsked = false;
  bool cameraAsked = false;
  String? tempUserID;
  late _LocalUser? userData;
  // maybe this should take an array/list of type CachedGivts
  List<_CachedGivts> cachedGivts = [];
}

@RealmModel()
class _LocalUser {
  // non_constant_identifier_names
  String email = "";
  String userId = "";
  String iBAN = "";
  String phoneNumber = "";
  String firstName = "";
  String lastName = "";
  String address = "";
  String city = "";
  String postalCode = "";
  String country = "";
  int amountLimit = 10000;
  String appLanguage = "";
  String timeZoneId = "";
}

@RealmModel()
class _CachedGivts {
  // does it need to store more data?
  // it SEEMS TO needs to store some id/ token
  late final String mediumId;
  late final int donationAmount;
  // Is this just dateTime.now()???
  late final DateTime dateTime;
  late final String? userId;
  // should this then have a token?
}

/// A proxy of the data
/// should this be a separate file? i like it here but maybeee
class LocalStorageProxy {
  late Realm realm;

  LocalStorageProxy() {
    var config = Configuration.local(
        [LocalStorage.schema, CachedGivts.schema, LocalUser.schema]);
    realm = Realm(config);

    if (realm.all<LocalStorage>().isEmpty) {
      realm.write(() {
        realm.add(LocalStorage(
          locationAsked: false,
          cameraAsked: false,
        ));
        realm.all<LocalStorage>().first.userData = LocalUser();
      });
    }
  }

  void createCachedGivt(mediumId, donationAmount, dateTime, givenUserId) {
    realm.write(() {
      LocalStorage localCurrent = realm.all<LocalStorage>().first;
      localCurrent.cachedGivts
          .add(CachedGivts(mediumId, donationAmount, dateTime, givenUserId));
    });
  }

  void addTempUserID(String id) {
    realm.write(() {
      realm.all<LocalStorage>().first.tempUserID = id;
    });
  }

  void createUser(
    email,
    userId,
    iBAN,
    phoneNumber,
    firstName,
    lastName,
    address,
    city,
    postalCode,
    country,
    amountLimit,
    appLanguage,
    timeZoneId,
  ) {
    realm.write(() {
      LocalUser localCurrent = realm.all<LocalStorage>().first.userData!;
      localCurrent.userId = userId;
      localCurrent.iBAN = iBAN;
      localCurrent.phoneNumber = phoneNumber;
      localCurrent.firstName = firstName;
      localCurrent.lastName = lastName;
      localCurrent.address = address;
      localCurrent.city = city;
      localCurrent.postalCode = postalCode;
      localCurrent.country = country;
      localCurrent.amountLimit = amountLimit;
      localCurrent.appLanguage = appLanguage;
      localCurrent.timeZoneId = timeZoneId;
    });
  }

  void updateProgress(String key) {
    realm.write(() {
      LocalStorage localCurrent = realm.all<LocalStorage>().first;
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
      LocalStorage localCurrent = realm.all<LocalStorage>().first;
      if (key == 'camera') {
        localCurrent.cameraAsked = false;
      }
      if (key == 'location') {
        localCurrent.locationAsked = false;
      }
    });
  }
}
