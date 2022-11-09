import 'package:realm/realm.dart';
import 'registered_user.dart';
// Realm: Declare a part file
part 'localStorage.g.dart';

@RealmModel()
class _LocalStorage {
  bool welcomed = false;
  bool completedOneDonation = false;
  late _LocalUser? userData;
  List<_Donations> donations = [];
}

@RealmModel()
class _LocalUser {
  // instance of User
  String email = "";
  String userId = "";
  int deviceOS = 0;
  String phoneNumber = "";
  String firstName = "";
  String lastName = "";
  String postalCode = "";
  String country = "";
  String password = "";
  String appLanguage = "";
  String timeZoneId = "";
}

@RealmModel()
class _Donations {
  // does it need to store more data?
  // it SEEMS TO needs to store some id/ token
  late final String mediumId;
  late final double donationAmount;
  // this should be an ISO8601 format
  late final String dateTime;
  late final String userId;
  // should this then have a token? -- no for now
}

/// A proxy of the data
/// should this be a separate file? i like it here but maybeee
class LocalStorageProxy {
  late Realm realm;

  LocalStorageProxy() {
    var config = Configuration.local(
        [LocalStorage.schema, Donations.schema, LocalUser.schema]);
    realm = Realm(config);
    if (realm.all<LocalStorage>().isEmpty) {
      realm.write(() {
        realm.add(LocalStorage(
          welcomed: false,
          completedOneDonation: false,
        ));
        realm.all<LocalStorage>().first.userData = LocalUser();
      });
    }
  }

  void createCachedGivt(mediumId, donationAmount, dateTime, userId) {
    realm.write(() {
      LocalStorage localCurrent = realm.all<LocalStorage>().first;
      localCurrent.donations
          .add(Donations(mediumId, donationAmount, dateTime, userId));
    });
  }

  void addUserId(String id) {
    realm.write(() {
      LocalUser localCurrent = realm.all<LocalStorage>().first.userData!;
      localCurrent.userId = id;
    });
  }

  void createUser(RegisteredUser user) {
    realm.write(() {
      LocalUser localCurrent = realm.all<LocalStorage>().first.userData!;
      localCurrent.userId = user.guid;
      localCurrent.email = user.email;
      localCurrent.deviceOS = user.deviceOS;
      localCurrent.phoneNumber = user.phoneNumber;
      localCurrent.firstName = user.firstName;
      localCurrent.lastName = user.lastName;
      localCurrent.postalCode = user.postalCode;
      localCurrent.country = user.country;
      localCurrent.password = user.password;
      localCurrent.appLanguage = user.appLanguage;
      localCurrent.timeZoneId = user.timeZoneId;
    });
  }

  void updateProgress(String key) {
    realm.write(() {
      LocalStorage localCurrent = realm.all<LocalStorage>().first;
      if (key == 'welcomed') {
        localCurrent.welcomed = true;
      }
      if (key == 'completedOneDonation') {
        localCurrent.completedOneDonation = true;
      }
    });
  }

  // // this is utility for resetting the flow
  // void downgradeProgress(String key) {
  //   realm.write(() {
  //     LocalStorage localCurrent = realm.all<LocalStorage>().first;
  //     if (key == 'camera') {
  //       localCurrent.cameraAsked = false;
  //     }
  //     if (key == 'location') {
  //       localCurrent.locationAsked = false;
  //     }
  //   });
  // }
}
