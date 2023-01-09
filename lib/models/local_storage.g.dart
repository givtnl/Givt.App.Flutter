// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_storage.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class LocalStorage extends _LocalStorage with RealmEntity, RealmObject {
  LocalStorage({
    PersistentState? persistentState,
    LocalUser? userData,
    Iterable<Donation> donations = const [],
    Iterable<ChildUser> children = const [],
  }) {
    RealmObject.set(this, 'persistentState', persistentState);
    RealmObject.set(this, 'userData', userData);
    RealmObject.set<RealmList<Donation>>(
        this, 'donations', RealmList<Donation>(donations));
    RealmObject.set<RealmList<ChildUser>>(
        this, 'children', RealmList<ChildUser>(children));
  }

  LocalStorage._();

  @override
  PersistentState? get persistentState =>
      RealmObject.get<PersistentState>(this, 'persistentState')
          as PersistentState?;
  @override
  set persistentState(covariant PersistentState? value) =>
      RealmObject.set(this, 'persistentState', value);

  @override
  LocalUser? get userData =>
      RealmObject.get<LocalUser>(this, 'userData') as LocalUser?;
  @override
  set userData(covariant LocalUser? value) =>
      RealmObject.set(this, 'userData', value);

  @override
  RealmList<Donation> get donations =>
      RealmObject.get<Donation>(this, 'donations') as RealmList<Donation>;
  @override
  set donations(covariant RealmList<Donation> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<ChildUser> get children =>
      RealmObject.get<ChildUser>(this, 'children') as RealmList<ChildUser>;
  @override
  set children(covariant RealmList<ChildUser> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<LocalStorage>> get changes =>
      RealmObject.getChanges<LocalStorage>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(LocalStorage._);
    return const SchemaObject(LocalStorage, 'LocalStorage', [
      SchemaProperty('persistentState', RealmPropertyType.object,
          optional: true, linkTarget: 'PersistentState'),
      SchemaProperty('userData', RealmPropertyType.object,
          optional: true, linkTarget: 'LocalUser'),
      SchemaProperty('donations', RealmPropertyType.object,
          linkTarget: 'Donation', collectionType: RealmCollectionType.list),
      SchemaProperty('children', RealmPropertyType.object,
          linkTarget: 'ChildUser', collectionType: RealmCollectionType.list),
    ]);
  }
}

class PersistentState extends _PersistentState with RealmEntity, RealmObject {
  static var _defaultsSet = false;

  PersistentState({
    bool welcomed = false,
    bool completedOneDonation = false,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObject.setDefaults<PersistentState>({
        'welcomed': false,
        'completedOneDonation': false,
      });
    }
    RealmObject.set(this, 'welcomed', welcomed);
    RealmObject.set(this, 'completedOneDonation', completedOneDonation);
  }

  PersistentState._();

  @override
  bool get welcomed => RealmObject.get<bool>(this, 'welcomed') as bool;
  @override
  set welcomed(bool value) => RealmObject.set(this, 'welcomed', value);

  @override
  bool get completedOneDonation =>
      RealmObject.get<bool>(this, 'completedOneDonation') as bool;
  @override
  set completedOneDonation(bool value) =>
      RealmObject.set(this, 'completedOneDonation', value);

  @override
  Stream<RealmObjectChanges<PersistentState>> get changes =>
      RealmObject.getChanges<PersistentState>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(PersistentState._);
    return const SchemaObject(PersistentState, 'PersistentState', [
      SchemaProperty('welcomed', RealmPropertyType.bool),
      SchemaProperty('completedOneDonation', RealmPropertyType.bool),
    ]);
  }
}

class ChildUser extends _ChildUser with RealmEntity, RealmObject {
  ChildUser(
    String childName,
  ) {
    RealmObject.set(this, 'childName', childName);
  }

  ChildUser._();

  @override
  String get childName => RealmObject.get<String>(this, 'childName') as String;
  @override
  set childName(String value) => RealmObject.set(this, 'childName', value);

  @override
  Stream<RealmObjectChanges<ChildUser>> get changes =>
      RealmObject.getChanges<ChildUser>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(ChildUser._);
    return const SchemaObject(ChildUser, 'ChildUser', [
      SchemaProperty('childName', RealmPropertyType.string),
    ]);
  }
}

class LocalUser extends _LocalUser with RealmEntity, RealmObject {
  static var _defaultsSet = false;

  LocalUser({
    String email = "",
    String userId = "",
    int deviceOS = 0,
    String phoneNumber = "",
    String firstName = "",
    String lastName = "",
    String postalCode = "",
    String country = "",
    String password = "",
    String appLanguage = "",
    String timeZoneId = "",
    String accessToken = "",
    String refreshToken = "",
    String expires = "",
    int expiresIn = 0,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObject.setDefaults<LocalUser>({
        'email': "",
        'userId': "",
        'deviceOS': 0,
        'phoneNumber': "",
        'firstName': "",
        'lastName': "",
        'postalCode': "",
        'country': "",
        'password': "",
        'appLanguage': "",
        'timeZoneId': "",
        'accessToken': "",
        'refreshToken': "",
        'expires': "",
        'expiresIn': 0,
      });
    }
    RealmObject.set(this, 'email', email);
    RealmObject.set(this, 'userId', userId);
    RealmObject.set(this, 'deviceOS', deviceOS);
    RealmObject.set(this, 'phoneNumber', phoneNumber);
    RealmObject.set(this, 'firstName', firstName);
    RealmObject.set(this, 'lastName', lastName);
    RealmObject.set(this, 'postalCode', postalCode);
    RealmObject.set(this, 'country', country);
    RealmObject.set(this, 'password', password);
    RealmObject.set(this, 'appLanguage', appLanguage);
    RealmObject.set(this, 'timeZoneId', timeZoneId);
    RealmObject.set(this, 'accessToken', accessToken);
    RealmObject.set(this, 'refreshToken', refreshToken);
    RealmObject.set(this, 'expires', expires);
    RealmObject.set(this, 'expiresIn', expiresIn);
  }

  LocalUser._();

  @override
  String get email => RealmObject.get<String>(this, 'email') as String;
  @override
  set email(String value) => RealmObject.set(this, 'email', value);

  @override
  String get userId => RealmObject.get<String>(this, 'userId') as String;
  @override
  set userId(String value) => RealmObject.set(this, 'userId', value);

  @override
  int get deviceOS => RealmObject.get<int>(this, 'deviceOS') as int;
  @override
  set deviceOS(int value) => RealmObject.set(this, 'deviceOS', value);

  @override
  String get phoneNumber =>
      RealmObject.get<String>(this, 'phoneNumber') as String;
  @override
  set phoneNumber(String value) => RealmObject.set(this, 'phoneNumber', value);

  @override
  String get firstName => RealmObject.get<String>(this, 'firstName') as String;
  @override
  set firstName(String value) => RealmObject.set(this, 'firstName', value);

  @override
  String get lastName => RealmObject.get<String>(this, 'lastName') as String;
  @override
  set lastName(String value) => RealmObject.set(this, 'lastName', value);

  @override
  String get postalCode =>
      RealmObject.get<String>(this, 'postalCode') as String;
  @override
  set postalCode(String value) => RealmObject.set(this, 'postalCode', value);

  @override
  String get country => RealmObject.get<String>(this, 'country') as String;
  @override
  set country(String value) => RealmObject.set(this, 'country', value);

  @override
  String get password => RealmObject.get<String>(this, 'password') as String;
  @override
  set password(String value) => RealmObject.set(this, 'password', value);

  @override
  String get appLanguage =>
      RealmObject.get<String>(this, 'appLanguage') as String;
  @override
  set appLanguage(String value) => RealmObject.set(this, 'appLanguage', value);

  @override
  String get timeZoneId =>
      RealmObject.get<String>(this, 'timeZoneId') as String;
  @override
  set timeZoneId(String value) => RealmObject.set(this, 'timeZoneId', value);

  @override
  String get accessToken =>
      RealmObject.get<String>(this, 'accessToken') as String;
  @override
  set accessToken(String value) => RealmObject.set(this, 'accessToken', value);

  @override
  String get refreshToken =>
      RealmObject.get<String>(this, 'refreshToken') as String;
  @override
  set refreshToken(String value) =>
      RealmObject.set(this, 'refreshToken', value);

  @override
  String get expires => RealmObject.get<String>(this, 'expires') as String;
  @override
  set expires(String value) => RealmObject.set(this, 'expires', value);

  @override
  int get expiresIn => RealmObject.get<int>(this, 'expiresIn') as int;
  @override
  set expiresIn(int value) => RealmObject.set(this, 'expiresIn', value);

  @override
  Stream<RealmObjectChanges<LocalUser>> get changes =>
      RealmObject.getChanges<LocalUser>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(LocalUser._);
    return const SchemaObject(LocalUser, 'LocalUser', [
      SchemaProperty('email', RealmPropertyType.string),
      SchemaProperty('userId', RealmPropertyType.string),
      SchemaProperty('deviceOS', RealmPropertyType.int),
      SchemaProperty('phoneNumber', RealmPropertyType.string),
      SchemaProperty('firstName', RealmPropertyType.string),
      SchemaProperty('lastName', RealmPropertyType.string),
      SchemaProperty('postalCode', RealmPropertyType.string),
      SchemaProperty('country', RealmPropertyType.string),
      SchemaProperty('password', RealmPropertyType.string),
      SchemaProperty('appLanguage', RealmPropertyType.string),
      SchemaProperty('timeZoneId', RealmPropertyType.string),
      SchemaProperty('accessToken', RealmPropertyType.string),
      SchemaProperty('refreshToken', RealmPropertyType.string),
      SchemaProperty('expires', RealmPropertyType.string),
      SchemaProperty('expiresIn', RealmPropertyType.int),
    ]);
  }
}

class Donation extends _Donation with RealmEntity, RealmObject {
  Donation(
    String mediumId,
    double donationAmount,
    String dateTime,
    String guid,
  ) {
    RealmObject.set(this, 'mediumId', mediumId);
    RealmObject.set(this, 'donationAmount', donationAmount);
    RealmObject.set(this, 'dateTime', dateTime);
    RealmObject.set(this, 'guid', guid);
  }

  Donation._();

  @override
  String get mediumId => RealmObject.get<String>(this, 'mediumId') as String;
  @override
  set mediumId(String value) => throw RealmUnsupportedSetError();

  @override
  double get donationAmount =>
      RealmObject.get<double>(this, 'donationAmount') as double;
  @override
  set donationAmount(double value) => throw RealmUnsupportedSetError();

  @override
  String get dateTime => RealmObject.get<String>(this, 'dateTime') as String;
  @override
  set dateTime(String value) => throw RealmUnsupportedSetError();

  @override
  String get guid => RealmObject.get<String>(this, 'guid') as String;
  @override
  set guid(String value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Donation>> get changes =>
      RealmObject.getChanges<Donation>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Donation._);
    return const SchemaObject(Donation, 'Donation', [
      SchemaProperty('mediumId', RealmPropertyType.string),
      SchemaProperty('donationAmount', RealmPropertyType.double),
      SchemaProperty('dateTime', RealmPropertyType.string),
      SchemaProperty('guid', RealmPropertyType.string),
    ]);
  }
}
