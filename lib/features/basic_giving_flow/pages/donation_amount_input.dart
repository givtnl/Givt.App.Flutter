import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/controller/input_controller.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/campaign_info.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/campaign_stats.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/input_button_donation.dart';

class DoantionAmountInput extends StatefulWidget {
  DoantionAmountInput({super.key});

  @override
  State<DoantionAmountInput> createState() => _DoantionAmountInputState();
}

class _DoantionAmountInputState extends State<DoantionAmountInput> {
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
  // for user input
  final _amountController = TextEditingController();

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
          child: SingleChildScrollView(
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
                  goalMoney: FetchedInfo['goalMoney'],
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
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
                        InputButton(
                          child: TextField(
                            autofocus: true,
                            textAlign: TextAlign.start,
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                    ),
                            decoration: InputDecoration(
                              // none of these show up wtf...
                              hoverColor: Colors.red,
                              focusColor: Colors.green,
                              fillColor: Colors.yellow,
                              // up to here

                              prefix: Text(
                                '\$',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                    ),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(width: 0)),
                            ),
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            onSubmitted: (_) {
                              InputController(context).handleSubmit(
                                  _amountController.text,
                                  FetchedInfo['mediumId']);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
