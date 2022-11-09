import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:givt_mobile_apps/models/localStorage.dart';

import 'package:givt_mobile_apps/core/widgets/buttons/generic_button.dart';
import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

class SuccessDonationPage extends StatelessWidget {
  SuccessDonationPage({super.key});

  final NavigationService _navigationService = locator<NavigationService>();
  late final LocalStorageProxy storageProxy = locator<LocalStorageProxy>();
  @override
  void initState() {
    storageProxy.updateProgress('completedOneDonation');
  }

  @override
  Widget build(BuildContext context) {
    // this could be state rather the quering from local storage
    LocalUser localUser =
        storageProxy.realm.all<LocalStorage>().first.userData!;
    CachedGivts? localDonation = storageProxy.realm
        .all<LocalStorage>()
        .first
        .cachedGivts
        .firstWhere((element) => element.userId == localUser.userId);

    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.all(35),
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
                'Thank you for your \$${localDonation.donationAmount} donation to the First Church of Atlanta!',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                      color: Colors.white,
                    ),
              ),
            ],
          ),
          GenericButton(
            text: 'Create an account',
            disabled: false,
            primaryColor: Theme.of(context).canvasColor,
            textColor: Theme.of(context).colorScheme.surface,
            onClicked: () => _navigationService.navigateTo(routes.SignUpRoute),
          )
        ],
      ),
    );
  }
}
