import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:givt_mobile_apps/models/localStorage.dart';

import 'package:givt_mobile_apps/core/widgets/buttons/generic_button.dart';
import 'package:provider/provider.dart';
import '../../../models/organisation.dart';
import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

class SuccessDonationPage extends StatefulWidget {
  SuccessDonationPage({super.key});

  @override
  State<SuccessDonationPage> createState() => _SuccessDonationPageState();
}

class _SuccessDonationPageState extends State<SuccessDonationPage> {
  Map<int, String> benefits = {
    0: 'You can get a personal tax statement from Givt?',
    1: 'You can set a personal giving target in the Givt app?',
    2: 'You can see an overview of your donation history with Givt?'
  };
  int benefitNr = 0;

  final NavigationService _navigationService = locator<NavigationService>();
  late final LocalStorageProxy storageProxy = locator<LocalStorageProxy>();
  @override
  void initState() {
    storageProxy.setCompletedOneDonationFlag(true);
  }

  @override
  void initState() {
    // TODO: implement initState
    Random random = new Random();
    int benefitNr = random.nextInt(2);
    print('random number is ${benefitNr}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final organisationProvider =
        Provider.of<Organisation>(context, listen: false);
    // this could be state rather the quering from local storage
    LocalUser localUser =
        storageProxy.realm.all<LocalStorage>().first.userData!;
    Donations? localDonation = storageProxy.realm
        .all<LocalStorage>()
        .first
        .donations
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
                'Thank you for your \$${localDonation.donationAmount} donation to the ${organisationProvider.organisationName}',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                      color: Colors.white,
                    ),
              ),
            ],
          ),
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
                      benefits[2]!,
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
          )
        ],
      ),
    );
  }
}
