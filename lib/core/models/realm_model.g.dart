// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class OnboardingProgress extends _OnboardingProgress
    with RealmEntity, RealmObject {
  static var _defaultsSet = false;

  OnboardingProgress({
    bool locationAsked = false,
    bool cameraAsked = false,
    bool emailRegistered = false,
    OnboardedUser? user,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObject.setDefaults<OnboardingProgress>({
        'locationAsked': false,
        'cameraAsked': false,
        'emailRegistered': false,
      });
    }
    RealmObject.set(this, 'locationAsked', locationAsked);
    RealmObject.set(this, 'cameraAsked', cameraAsked);
    RealmObject.set(this, 'emailRegistered', emailRegistered);
    RealmObject.set(this, 'user', user);
  }

  OnboardingProgress._();

  @override
  bool get locationAsked =>
      RealmObject.get<bool>(this, 'locationAsked') as bool;
  @override
  set locationAsked(bool value) =>
      RealmObject.set(this, 'locationAsked', value);

  @override
  bool get cameraAsked => RealmObject.get<bool>(this, 'cameraAsked') as bool;
  @override
  set cameraAsked(bool value) => RealmObject.set(this, 'cameraAsked', value);

  @override
  bool get emailRegistered =>
      RealmObject.get<bool>(this, 'emailRegistered') as bool;
  @override
  set emailRegistered(bool value) =>
      RealmObject.set(this, 'emailRegistered', value);

  @override
  OnboardedUser? get user =>
      RealmObject.get<OnboardedUser>(this, 'user') as OnboardedUser?;
  @override
  set user(covariant OnboardedUser? value) =>
      RealmObject.set(this, 'user', value);

  @override
  Stream<RealmObjectChanges<OnboardingProgress>> get changes =>
      RealmObject.getChanges<OnboardingProgress>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(OnboardingProgress._);
    return const SchemaObject(OnboardingProgress, 'OnboardingProgress', [
      SchemaProperty('locationAsked', RealmPropertyType.bool),
      SchemaProperty('cameraAsked', RealmPropertyType.bool),
      SchemaProperty('emailRegistered', RealmPropertyType.bool),
      SchemaProperty('user', RealmPropertyType.object,
          optional: true, linkTarget: 'OnboardedUser'),
    ]);
  }
}

class OnboardedUser extends _OnboardedUser with RealmEntity, RealmObject {
  OnboardedUser(
    String email,
  ) {
    RealmObject.set(this, 'email', email);
  }

  OnboardedUser._();

  @override
  String get email => RealmObject.get<String>(this, 'email') as String;
  @override
  set email(String value) => RealmObject.set(this, 'email', value);

  @override
  Stream<RealmObjectChanges<OnboardedUser>> get changes =>
      RealmObject.getChanges<OnboardedUser>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(OnboardedUser._);
    return const SchemaObject(OnboardedUser, 'OnboardedUser', [
      SchemaProperty('email', RealmPropertyType.string),
    ]);
  }
}
