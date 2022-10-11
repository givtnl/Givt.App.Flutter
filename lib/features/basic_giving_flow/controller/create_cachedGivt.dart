import 'package:givt_mobile_apps/models/localStorage.dart';

import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

void createCachedGivtandNavigate(int donationAmount, String mediumId) {
  DateTime dateTime = DateTime.now();

  final NavigationService navigationService = locator<NavigationService>();
  final LocalUserProxy model = locator<LocalUserProxy>();

// fourth arg is null bc the current flow doesnt register the email so it does not fetch the userId
  model.createCachedGivt(mediumId, donationAmount, dateTime, null);

// this should navigate to the iframescreen
  navigationService.navigateTo(routes.DonationSuccessRoute);
}
