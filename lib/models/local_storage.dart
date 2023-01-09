import 'package:realm/realm.dart';
// Realm: Declare a part file
part 'local_storage.g.dart';

@RealmModel()
class _LocalStorage {
  late _PersistentState? persistentState;
  late _LocalUser? userData;
  List<_Donation> donations = [];
  List<_ChildUser> children = [];
}

@RealmModel()
class _PersistentState {
  bool welcomed = false;
  bool completedOneDonation = false;
}

@RealmModel()
class _ChildUser {
  late String childName;
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
  String accessToken = "";
  String refreshToken = "";
  String expires = "";
  int expiresIn = 0;
}

@RealmModel()
class _Donation {
  // does it need to store more data?
  // it SEEMS TO needs to store some id/ token
  late final String mediumId;
  late final double donationAmount;

  /// this should be an ISO8601 format string
  /// but it could be a DateTime object that only converted when encoded
  late final String dateTime;

  /// could be a Uuid
  late final String guid;
  // should this then have a token? -- no for now
}
