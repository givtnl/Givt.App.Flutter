import 'package:givt_mobile_apps/services/local_storage_service.dart';
import 'package:givt_mobile_apps/utils/ilocal_storage.dart';

import '../models/local_storage.dart';

class LocalChildUserService extends LocalStorageBase
    implements IChildUsersRepository {
  @override
  void createChildUser(entity) {
    realm.write(() {
      LocalStorage localStorage = realm.all<LocalStorage>().first;
      localStorage.children.add(entity);
    });
  }

  @override
  void updateChildUser(entity) {
    // TODO: implement updateChildUser
  }

  @override
  List<ChildUser> getAllChildUsers() {
    List<ChildUser> ChildUsers = realm.all<ChildUser>().toList();
    return ChildUsers;
  }

  @override
  void deleteChildUser(entity) {
// TODO: implement deleteChildUser
  }
}
