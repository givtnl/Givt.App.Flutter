import 'package:realm/realm.dart';
import '../models/local_storage.dart';
import '../models/registered_user.dart';

class LocalStorageProxy {
  late Realm realm;

  LocalStorageProxy() {
    var config = Configuration.local([
      LocalStorage.schema,
      PersistentState.schema,
      Donations.schema,
      LocalUser.schema
    ], schemaVersion: 2);
    realm = Realm(config);
    if (realm.all<LocalStorage>().isEmpty) {
      realm.write(() {
        realm.all<LocalStorage>().first.persistentState = PersistentState();
        realm.all<LocalStorage>().first.userData = LocalUser();
      });
    }
    if (realm.all<PersistentState>().isEmpty) {
      realm.write(() {
        realm.all<LocalStorage>().first.persistentState = PersistentState();
      });
    }
    if (realm.all<LocalUser>().isEmpty) {
      realm.write(() {
        realm.all<LocalStorage>().first.userData = LocalUser();
      });
    }
  }
  setWelcomeFlag(bool update) {
    realm.write(() {
      realm.all<PersistentState>().first.welcomed = update;
    });
  }

  void setCompletedOneDonationFlag(bool update) {
    realm.write(() {
      realm.all<PersistentState>().first.completedOneDonation = update;
    });
  }

  void createLocalDonation(mediumId, donationAmount, dateTime, userId) {
    realm.write(() {
      LocalStorage localStorage = realm.all<LocalStorage>().first;
      localStorage.donations
          .add(Donations(mediumId, donationAmount, dateTime, userId));
    });
  }

  void addUserId(String id) {
    realm.write(() {
      LocalUser localUser = realm.all<LocalStorage>().first.userData!;
      localUser.userId = id;
    });
  }

  void createUser(RegisteredUser user) {
    realm.write(() {
      LocalUser localUser = realm.all<LocalStorage>().first.userData!;
      localUser.userId = user.userId;
      localUser.email = user.email;
      localUser.deviceOS = user.deviceOS;
      localUser.phoneNumber = user.phoneNumber;
      localUser.firstName = user.firstName;
      localUser.lastName = user.lastName;
      localUser.postalCode = user.postalCode;
      localUser.country = user.country;
      localUser.password = user.password;
      localUser.appLanguage = user.appLanguage;
      localUser.timeZoneId = user.timeZoneId;
    });
  }
}
