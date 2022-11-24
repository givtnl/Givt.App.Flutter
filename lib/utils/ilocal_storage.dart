abstract class IStateRepository {
  void updateWelcomeFlag(bool update) {}
  void updateCompletedOneDonationFlag(bool update) {}
}

abstract class IDonationsRepository<TEntity> {
  void createDonation(TEntity entity);
  void updateDonation(TEntity entity);
  void deleteDonation(TEntity entity);
  List<TEntity> getAllDonations();
  // it needs some sort of id, maybe it gets returned by donation
  TEntity getDonationByTime(String dateTime);
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
