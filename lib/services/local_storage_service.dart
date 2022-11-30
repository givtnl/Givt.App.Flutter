import 'package:realm/realm.dart';
import '../models/local_storage.dart';

class LocalStorageBase {
  late Realm realm;

  LocalStorageBase() {
    var config = Configuration.local([
      LocalStorage.schema,
      PersistentState.schema,
      Donation.schema,
      LocalUser.schema
    ], schemaVersion: 3);
    realm = Realm(config);
    if (realm.all<LocalStorage>().isEmpty) {
      final localStorage = LocalStorage();
      realm.write(() {
        realm.add(localStorage);
        localStorage.persistentState = PersistentState();
        localStorage.userData = LocalUser();
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
}
