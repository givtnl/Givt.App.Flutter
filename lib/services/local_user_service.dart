import 'package:givt_mobile_apps/services/local_storage_service.dart';
import 'package:givt_mobile_apps/utils/ilocal_storage.dart';

import '../models/local_storage.dart';

class LocalUserService extends LocalStorageBase
    implements ILocalUserRepository {
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
      localUser.accessToken = user.accessToken;
      localUser.refreshToken = user.refreshToken;
      localUser.expires = user.expires;
      localUser.expiresIn = user.expiresIn;
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
