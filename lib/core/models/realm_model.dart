import 'package:realm/realm.dart';
part 'realm_model.g.dart';

@RealmModel()
class _OnboardingProgress {
  bool locationAsked = false;
  bool cameraAsked = false;
  bool emailRegistered = false;
  _OnboardedUser? user;
}

@RealmModel()
class _OnboardedUser {
  late String email;
}
