import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/amount_input.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/campaign_info.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/campaign_stats.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/donation_button.dart';
import 'package:givt_mobile_apps/core/templates/base_template.dart';

class DoantionAmount extends StatefulWidget {
  DoantionAmount({super.key});

  @override
  State<DoantionAmount> createState() => _DoantionAmountState();
}

class _DoantionAmountState extends State<DoantionAmount> {
// should be received from QR scan, gotten from database, etc
  Map<String, dynamic> FetchedInfo = {
    "orgName": 'First Church of Atlanta',
    'orgCause': 'Donate to the youth ministry trip to Equador',
    "orgCauseDescription":
        'A short explanation about the youth ministry trip to Equador and what the money being raised will be used for Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    "currentMoney": 9342,
    'goalMoney': 12000,
    'days': 12,
  };

// this is for controlling the amount
  int? donationAmount;

  bool selectedMin = false;
  bool selectedMed = false;
  bool selectedMax = false;
  bool otherInput = true;

  void openInputDifferntAmount(BuildContext ctx) {
    //function provided by flutter
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return AmountInput();
        });
  }

  void selectedTypicalAmount(selection) {
    setState(() {
      switch (selection) {
        case "selectedMin":
          selectedMin = true;
          selectedMed = false;
          selectedMax = false;
          donationAmount = 5;
          break;
        case "selectedMed":
          selectedMin = false;
          selectedMed = true;
          selectedMax = false;
          donationAmount = 10;
          break;
        case "selectedMax":
          selectedMin = false;
          selectedMed = false;
          selectedMax = true;
          donationAmount = 15;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
      pageContent: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CampaignInfo(
              orgCause: FetchedInfo["orgCause"],
              orgCauseDescription: FetchedInfo['orgCauseDescription'],
              orgName: FetchedInfo['orgName'],
            ),
            CampaignStats(
                currentMoney: FetchedInfo['currentMoney'],
                days: FetchedInfo['days'],
                goalMoney: FetchedInfo['goalMoney']),
            Center(
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
                    onPressed: () => selectedTypicalAmount('selectedMin'),
                    label: '\$5',
                  ),
                  DonationButton(
                    filled: selectedMed,
                    bold: true,
                    onPressed: () => selectedTypicalAmount('selectedMed'),
                    label: '\$10',
                  ),
                  DonationButton(
                    filled: selectedMax,
                    bold: true,
                    onPressed: () => selectedTypicalAmount('selectedMax'),
                    label: '\$15',
                  ),
                  DonationButton(
                      filled: otherInput,
                      //this one has to open the input field
                      onPressed: () {
                        openInputDifferntAmount(context);
                      },
                      label: 'Enter a different amount'),
                ],
              ),
            )
          ],
        ),
      ),
      // this one should actually create a new cached givt then navigate
      onBtnClick: () {},
      title: 'Continue',
      isBtnDisabled: false,
      logoHeight: 0,
    );
  }
}
