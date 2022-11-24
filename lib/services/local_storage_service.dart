import 'package:realm/realm.dart';
import '../models/local_storage.dart';
import '../utils/ilocal_storage.dart';

class LocalStorageProxy
    implements IStateRepository, IDonationsRepository, ILocalUserRepository {
  late Realm realm;

  LocalStorageProxy() {
    var config = Configuration.local([
      LocalStorage.schema,
      PersistentState.schema,
      Donation.schema,
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

  @override
  void updateCompletedOneDonationFlag(bool update) {
    realm.write(() {
      realm.all<PersistentState>().first.completedOneDonation = update;
    });
  }

  @override
  void updateWelcomeFlag(bool update) {
    realm.write(() {
      realm.all<PersistentState>().first.welcomed = update;
    });
  }

  @override
  void createDonation(entity) {
    realm.write(() {
      LocalStorage localStorage = realm.all<LocalStorage>().first;
      localStorage.donations.add(entity);
    });
  }

  @override
  void updateDonation(entity) {
    // TODO: implement updateDonation
  }

  @override
  List<Donation> getAllDonations() {
    List<Donation> donations = realm.all<Donation>().toList();
    return donations;
  }

  @override
  Donation getDonationByTime(dateTime) {
    Donation requestedDonation = realm
        .all<Donation>()
        .where((element) => element.dateTime == dateTime)
        .toList()
        .first;
    return requestedDonation;
  }

  @override
  void deleteDonation(entity) {
// TODO: implement deleteDonation
  }

  @override
  void postLocalUser(user) {
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

  @override
  void updateLocalUserGuid(String guid) {
    realm.write(() {
      LocalUser localUser = realm.all<LocalStorage>().first.userData!;
      localUser.userId = guid;
    });
  }

  @override
  LocalUser getLocalUser() {
    LocalUser localUser = realm.all<LocalUser>().first;
    return localUser;
  }

//why would this exist
  @override
  void deleteLocalUser() {
    LocalUser localUser = realm.all<LocalUser>().first;
    realm.delete(localUser);
  }
}
