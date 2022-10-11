import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/widgets/buttons/generic_button.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/controller/typical_donation_controller.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/controller/create_cachedGivt.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/campaign_info.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/campaign_stats.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/donation_button.dart';
import 'package:givt_mobile_apps/models/localStorage.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

class DoantionAmountTypical extends StatefulWidget {
  DoantionAmountTypical({super.key});

  @override
  State<DoantionAmountTypical> createState() => _DoantionAmountTypicalState();
}

class _DoantionAmountTypicalState extends State<DoantionAmountTypical> {
  final NavigationService _navigationService = locator<NavigationService>();
  final LocalUserProxy _model = locator<LocalUserProxy>();

// should be received from QR scan, gotten from database, etc
  Map<String, dynamic> FetchedInfo = {
    'mediumId': 'medium-receieved-from-qr',
    "orgName": 'First Church of Atlanta',
    'orgCause': 'Donate to the youth ministry trip to Equador',
    "orgCauseDescription":
        'A short explanation about the youth ministry trip to Equador and what the money being raised will be used for Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    "currentMoney": 9342,
    'goalMoney': 12000,
    'days': 12,
  };

  Map<String, dynamic> choice = {};
  bool selectedMin = false;
  bool selectedMed = false;
  bool selectedMax = false;
  bool otherInput = true;
  int donationAmount = 0;

  void selectedTypicalAmount(
      int amount, bool userInput, Map<String, dynamic> previous) {
    setState(() {
      choice = getAmount(amount, userInput, previous);
      selectedMin = choice["selectedMin"];
      selectedMed = choice["selectedMed"];
      selectedMax = choice["selectedMax"];
      donationAmount = choice["donationAmount"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // exit the keyboard when clicking outside of it.
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  CampaignInfo(
                    orgCause: FetchedInfo["orgCause"],
                    orgCauseDescription: FetchedInfo['orgCauseDescription'],
                    orgName: FetchedInfo['orgName'],
                  ),
                  CampaignStats(
                    currentMoney: FetchedInfo['currentMoney'],
                    days: FetchedInfo['days'],
                    goalMoney: FetchedInfo['goalMoney'],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 8),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                            child: Text(
                              'How much would you like to donate?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                          ),
                          // donation button sets the variable-amount
                          DonationButton(
                            filled: selectedMin,
                            bold: true,
                            onPressed: () =>
                                selectedTypicalAmount(5, false, results),
                            label: '\$5',
                          ),
                          DonationButton(
                            filled: selectedMed,
                            bold: true,
                            onPressed: () =>
                                selectedTypicalAmount(10, false, results),
                            label: '\$10',
                          ),
                          DonationButton(
                            filled: selectedMax,
                            bold: true,
                            onPressed: () =>
                                selectedTypicalAmount(15, false, results),
                            label: '\$15',
                          ),
                          DonationButton(
                              filled: otherInput,
                              onPressed: () => _navigationService
                                  .navigateTo(routes.DonationAmountInputRoute),
                              label: 'Enter a different amount'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              GenericButton(
                text: 'Next',
                disabled: donationAmount > 1.5 ? false : true,
                onClicked: () => createCachedGivtandNavigate(
                    donationAmount, FetchedInfo['mediumId']),
              )
            ],
          ),
        ),
      ),
    );
  }
}
