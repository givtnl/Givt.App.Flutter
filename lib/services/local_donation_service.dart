import 'package:givt_mobile_apps/services/local_storage_service.dart';
import 'package:givt_mobile_apps/utils/ilocal_storage.dart';

import '../models/local_storage.dart';

class LocalDonationService extends LocalStorageBase
    implements IDonationsRepository {
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
  List<Donation?> getDonationsById(String guid) {
    List<Donation?> localDonations =
        realm.all<Donation>().where((element) => element.guid == guid).toList();
    return localDonations;
  }
}
