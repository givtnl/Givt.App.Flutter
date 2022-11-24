import 'package:givt_mobile_apps/services/local_storage_service.dart';
import 'package:givt_mobile_apps/utils/ilocal_storage.dart';
import '../models/local_storage.dart';

class PersistentStateService extends LocalStorageBase
    implements IStateRepository {
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
}
