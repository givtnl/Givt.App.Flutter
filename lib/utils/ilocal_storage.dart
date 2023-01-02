import 'package:givt_mobile_apps/models/local_storage.dart';

abstract class IStateRepository {
  PersistentState getPersistentState();
  void updateWelcomeFlag(bool update);
  void updateCompletedOneFlowFlag(bool update);
}

abstract class IChildUsersRepository<ChildUser> {
  void createChildUser(ChildUser entity);
  void updateChildUser(ChildUser entity);
  void deleteChildUser(ChildUser entity);
  List<ChildUser> getAllChildUsers();
}

abstract class IDonationsRepository<Donation> {
  void createDonation(Donation entity);
  void updateDonation(Donation entity);
  void deleteDonation(Donation entity);
  List<Donation> getAllDonations();
  // it needs some sort of id, maybe it gets returned by donation
  Donation getDonationByTime(String dateTime);
  Donation getDonationsById(String guid);
}

abstract class ILocalUserRepository<TEntity> {
  void postLocalUser(TEntity entity);
  void updateLocalUserGuid(String guid);
  // i dont think this should exist
  void deleteLocalUser();
  TEntity getLocalUser();
}

// abstract class IRepository<TEntity> {
//   // CRUD
//   void create(TEntity entity);
//   void update(TEntity entity);
//   void delete(TEntity entity);
//   List<TEntity> getAll();
//   TEntity getById();
// }
