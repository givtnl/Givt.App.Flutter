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
