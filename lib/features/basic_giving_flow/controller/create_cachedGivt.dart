import 'package:givt_mobile_apps/models/localStorage.dart';

import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

void createCachedGivtandNavigate(int? donationAmount) {
  final NavigationService _navigationService = locator<NavigationService>();

  final LocalUserProxy _model = locator<LocalUserProxy>();
  LocalUser current = _model.realm.all<LocalUser>().first;

  _navigationService.navigateTo(routes.DonationSuccessRoute);
}
