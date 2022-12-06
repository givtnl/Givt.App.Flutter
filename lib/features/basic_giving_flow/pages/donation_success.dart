import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:givt_mobile_apps/models/local_storage.dart';

import 'package:givt_mobile_apps/core/widgets/buttons/generic_button.dart';
import 'package:givt_mobile_apps/services/local_donation_service.dart';
import 'package:givt_mobile_apps/services/local_storage_service.dart';
import 'package:givt_mobile_apps/services/local_user_service.dart';
import 'package:givt_mobile_apps/services/persistent_state_service.dart';
import 'package:provider/provider.dart';
import '../../../models/organisation.dart';
import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;
import '../../../core/constants/benefits.dart';

class SuccessDonationPage extends StatefulWidget {
  const SuccessDonationPage({super.key});

  @override
  State<SuccessDonationPage> createState() => _SuccessDonationPageState();
}

class _SuccessDonationPageState extends State<SuccessDonationPage> {
  final NavigationService _navigationService = locator<NavigationService>();
  final PersistentStateService _stateService =
      locator<PersistentStateService>();
  final LocalUserService _localUserService = locator<LocalUserService>();
  final LocalDonationService _localDonationService =
      locator<LocalDonationService>();
  @override
  void initState() {
    initialization();
    _stateService.updateCompletedOneDonationFlag(true);
    benefits.shuffle();
    super.initState();
  }

  void initialization() async {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    final organisationProvider =
        Provider.of<Organisation>(context, listen: false);
    final PersistentState state = _stateService.getPersistentState();

    // this could be state rather the quering from local storage
    LocalUser localUser = _localUserService.getLocalUser();
    //this only works because our donation flow always creates a user with a new guid, we should have a donation guid.
    Donation? localDonation =
        _localDonationService.getDonationsById(localUser.userId).last;
    return Container(
      color: Theme.of(context).colorScheme.surface,
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
                'assets/svg/success_duotone.svg',
                height: 50,
              ),
              const SizedBox(height: 70),
              Text(
                'Thank you for your \$${localDonation?.donationAmount} donation to the ${organisationProvider.organisationName}',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                      color: Colors.white,
                    ),
              ),
            ],
          ),
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Container(
                  color: Theme.of(context).backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Did you know...',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(fontSize: 18),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          benefits[1],
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(color: Colors.black, fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        GenericButton(
                          text: 'Create an account',
                          disabled: false,
                          primaryColor: Colors.black,
                          textColor: Theme.of(context).backgroundColor,
                          onClicked: () =>
                              _navigationService.navigateTo(routes.SignUpRoute),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    _navigationService.navigateTo((state.completedOneDonation)
                        ? routes.HomeScreenRoute
                        : routes.FirstUseScreenRoute);
                  },
                  child: Text('Continue giving anonymously',
                      style: Theme.of(context).textTheme.headline6)),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
