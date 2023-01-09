import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/buttons/generic_button.dart';
import '../../../models/local_storage.dart';
import '../../../models/organisation.dart';
import '../../../services/local_donation_service.dart';
import '../../../services/local_user_service.dart';
import '../../../services/navigation_service.dart';
import '../../../services/persistent_state_service.dart';
import '../../../utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

class DonationFailedPage extends StatefulWidget {
  const DonationFailedPage({super.key});

  @override
  State<DonationFailedPage> createState() => _DonationFailedPageState();
}

class _DonationFailedPageState extends State<DonationFailedPage> {
  final NavigationService _navigationService = locator<NavigationService>();
  final PersistentStateService _stateService =
      locator<PersistentStateService>();
  final LocalUserService _localUserService = locator<LocalUserService>();
  final LocalDonationService _localDonationService =
      locator<LocalDonationService>();
  @override
  void initState() {
    initialization();
    _stateService.updateCompletedOneFlowFlag(true);
    super.initState();
  }

  void initialization() async {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    final organisationProvider =
        Provider.of<Organisation>(context, listen: false);
    // this could be state rather the quering from local storage
    LocalUser localUser = _localUserService.getLocalUser();
    //this only works because our donation flow always creates a user with a new guid, we should have a donation guid.
    Donation? localDonation =
        _localDonationService.getDonationsById(localUser.userId).last;
    return Container(
      color: Theme.of(context).colorScheme.error,
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              SvgPicture.asset(
                'assets/svg/fail.svg',
                height: 50,
              ),
              const SizedBox(height: 70),
              Text(
                'Oops, something went wrong.',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                      color: Colors.white,
                    ),
              ),
              Text(
                'Please try again.',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: Colors.white,
                    ),
              ),
            ],
          ),
          Column(
            children: [
              GenericButton(
                text: 'Start Over',
                disabled: false,
                primaryColor: Colors.black,
                textColor: Theme.of(context).backgroundColor,
                onClicked: () =>
                    _navigationService.navigateTo(routes.QRScannerPage),
              ),
              TextButton(
                  onPressed: () {
                    _navigationService.navigateTo(routes.HomeScreenRoute);
                  },
                  child: Text('Go back Home',
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: Colors.black,
                          ))),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
