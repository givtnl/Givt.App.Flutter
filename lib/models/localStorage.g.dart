// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localStorage.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class LocalStorage extends _LocalStorage with RealmEntity, RealmObject {
  static var _defaultsSet = false;

  LocalStorage({
    bool welcomed = false,
    bool completedOneDonation = false,
    LocalUser? userData,
    Iterable<CachedGivts> cachedGivts = const [],
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObject.setDefaults<LocalStorage>({
        'welcomed': false,
        'completedOneDonation': false,
      });
    }
    RealmObject.set(this, 'welcomed', welcomed);
    RealmObject.set(this, 'completedOneDonation', completedOneDonation);
    RealmObject.set(this, 'userData', userData);
    RealmObject.set<RealmList<CachedGivts>>(
        this, 'cachedGivts', RealmList<CachedGivts>(cachedGivts));
  }

  LocalStorage._();

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
  LocalUser? get userData =>
      RealmObject.get<LocalUser>(this, 'userData') as LocalUser?;
  @override
  set userData(covariant LocalUser? value) =>
      RealmObject.set(this, 'userData', value);

  @override
  RealmList<CachedGivts> get cachedGivts =>
      RealmObject.get<CachedGivts>(this, 'cachedGivts')
          as RealmList<CachedGivts>;
  @override
  set cachedGivts(covariant RealmList<CachedGivts> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<LocalStorage>> get changes =>
      RealmObject.getChanges<LocalStorage>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(LocalStorage._);
    return const SchemaObject(LocalStorage, 'LocalStorage', [
      SchemaProperty('welcomed', RealmPropertyType.bool),
      SchemaProperty('completedOneDonation', RealmPropertyType.bool),
      SchemaProperty('userData', RealmPropertyType.object,
          optional: true, linkTarget: 'LocalUser'),
      SchemaProperty('cachedGivts', RealmPropertyType.object,
          linkTarget: 'CachedGivts', collectionType: RealmCollectionType.list),
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
    ]);
  }
}

class CachedGivts extends _CachedGivts with RealmEntity, RealmObject {
  CachedGivts(
    String mediumId,
    int donationAmount,
    String dateTime,
    String userId,
  ) {
    RealmObject.set(this, 'mediumId', mediumId);
    RealmObject.set(this, 'donationAmount', donationAmount);
    RealmObject.set(this, 'dateTime', dateTime);
    RealmObject.set(this, 'userId', userId);
  }

  CachedGivts._();

  @override
  String get mediumId => RealmObject.get<String>(this, 'mediumId') as String;
  @override
  set mediumId(String value) => throw RealmUnsupportedSetError();

  @override
  int get donationAmount => RealmObject.get<int>(this, 'donationAmount') as int;
  @override
  set donationAmount(int value) => throw RealmUnsupportedSetError();

  @override
  String get dateTime => RealmObject.get<String>(this, 'dateTime') as String;
  @override
  set dateTime(String value) => throw RealmUnsupportedSetError();

  @override
  String get userId => RealmObject.get<String>(this, 'userId') as String;
  @override
  set userId(String value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<CachedGivts>> get changes =>
      RealmObject.getChanges<CachedGivts>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(CachedGivts._);
    return const SchemaObject(CachedGivts, 'CachedGivts', [
      SchemaProperty('mediumId', RealmPropertyType.string),
      SchemaProperty('donationAmount', RealmPropertyType.int),
      SchemaProperty('dateTime', RealmPropertyType.string),
      SchemaProperty('userId', RealmPropertyType.string),
    ]);
  }
}
