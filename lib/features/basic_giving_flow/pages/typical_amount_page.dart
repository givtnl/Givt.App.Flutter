import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/widgets/buttons/generic_button.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/controller/create_cachedGivt.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/campaign_info.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/campaign_stats.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/donation_button.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/donation_template.dart';
import 'package:givt_mobile_apps/models/localStorage.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
import 'package:givt_mobile_apps/utils/connection_check.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

class DoantionAmountTypical extends StatefulWidget {
  DoantionAmountTypical({super.key});

  @override
  State<DoantionAmountTypical> createState() => _DoantionAmountTypicalState();
}

class _DoantionAmountTypicalState extends State<DoantionAmountTypical> {
  final NavigationService _navigationService = locator<NavigationService>();
  final LocalStorageProxy _model = locator<LocalStorageProxy>();

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
    'typicalAmounts': [5, 10, 15],
  };

  int donationAmount = 0;
  int selection = -1;

  void selectedTypicalAmount(int index) {
    setState(() {
      if (selection == index) {
        selection = -1;
        donationAmount = 0;
        return;
      }
      selection = index;
      donationAmount = FetchedInfo['typicalAmounts'][index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return DoantionTemplate(
      questionText: "How much would you like to donate?",
      content: Column(children: [
        DonationButton(
          filled: (selection == 0),
          bold: true,
          onPressed: () => selectedTypicalAmount(0),
          label: '\$${FetchedInfo['typicalAmounts'][0]}',
        ),
        DonationButton(
          filled: (selection == 1),
          bold: true,
          onPressed: () => selectedTypicalAmount(1),
          label: '\$${FetchedInfo['typicalAmounts'][1]}',
        ),
        DonationButton(
          filled: (selection == 2),
          bold: true,
          onPressed: () => selectedTypicalAmount(2),
          label: '\$${FetchedInfo['typicalAmounts'][2]}',
        ),
        DonationButton(
            //filled: otherInput,
            specialColor: Theme.of(context).colorScheme.tertiary,
            onPressed: () =>
                _navigationService.navigateTo(routes.DonationAmountInputRoute),
            label: 'Enter a different amount'),
      ]),
      button: GenericButton(
        text: 'Next',
        disabled: donationAmount > 1.5 ? false : true,
        onClicked: () => createCachedGivtandNavigate(
            donationAmount, FetchedInfo['mediumId']),
      ),
    );
  }
}
        // Scaffold(
        //   backgroundColor: Theme.of(context).canvasColor,
        //   body: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 35),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Column(
        //           children: [
        //             CampaignInfo(
        //               orgCause: FetchedInfo["orgCause"],
        //               orgCauseDescription: FetchedInfo['orgCauseDescription'],
        //               orgName: FetchedInfo['orgName'],
        //             ),
        //             CampaignStats(
        //               currentMoney: FetchedInfo['currentMoney'],
        //               days: FetchedInfo['days'],
        //               goalMoney: FetchedInfo['goalMoney'],
        //             ),
        //             Center(
        //               child: Padding(
        //                 padding: const EdgeInsets.fromLTRB(0, 20, 0, 8),
        //                 child: Column(
        //                   children: [
        //                     Padding(
        //                       padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
        //                       child: Text(
        //                         'How much would you like to donate?',
        //                         style: Theme.of(context)
        //                             .textTheme
        //                             .bodyText1
        //                             ?.copyWith(fontWeight: FontWeight.w800),
        //                       ),
        //                     ),
        //                     // donation button sets the variable-amount

        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
                
        //       ],
        //     ),
        //   ),
        // ),
