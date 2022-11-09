import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/campaign_info.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/campaign_stats.dart';
import 'package:provider/provider.dart';

import '../../models/organisation.dart';

class DonationTemplate extends StatelessWidget {
  String questionText;
  Widget content;
  Widget? button;
  bool? wepay;
  DonationTemplate({
    super.key,
    required this.questionText,
    required this.content,
    this.button,
    this.wepay = false,
  });

  @override
  Widget build(BuildContext context) {
    final organisationProvider =
        Provider.of<Organisation>(context, listen: false);
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 45),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Column(
                        children: [
                          CampaignInfo(
                            orgCause: organisationProvider.title!,
                            orgCauseDescription: organisationProvider.goal!,
                            orgName: organisationProvider.organisationName!,
                          ),
                          // We will put this back when our organisation from the backend has these details
                          // CampaignStats(
                          //   currentMoney: FetchedInfo['currentMoney'],
                          //   days: FetchedInfo['days'],
                          //   goalMoney: FetchedInfo['goalMoney'],
                          // ),
                        ],
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                                child: Text(
                                  questionText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(fontWeight: FontWeight.w800),
                                ),
                              ),
                              content,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: button != null
            ? Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: button,
              )
            : const SizedBox(
                height: 0,
                width: 0,
              ),
      ),
    );
  }
}
