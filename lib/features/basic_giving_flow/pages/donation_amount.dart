import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/campaign_stats.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/donation_button.dart';
import 'package:readmore/readmore.dart';
import 'package:givt_mobile_apps/core/templates/base_template.dart';

class DoantionAmount extends StatelessWidget {
  const DoantionAmount({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
      pageContent: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // this doesnt work :(((
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                // should be passed as an argument
                'First Church of Atlanta',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                // should be passed as an argument
                'Donate to the youth ministry trip to Equador'.toUpperCase(),
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ReadMoreText(
                // should be passed as an argument
                'A short explanation about the youth ministry trip to Equador and what the money being raised will be used for Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                trimLines: 3,
                trimLength: 110,
                trimCollapsedText: ' Read more',
                trimExpandedText: ' Less',
                style: Theme.of(context).textTheme.bodyText2,
                moreStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(255, 53, 80, 112),
                    ),
                lessStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
            CampaignStats(currentMoney: 9342, days: 12, goalMoney: 12000),
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
                  DonationButton(
                    bold: true,
                    onPressed: () {},
                    label: '\$5',
                  ),
                  DonationButton(
                    bold: true,
                    onPressed: () {},
                    label: '\$10',
                  ),
                  DonationButton(
                    bold: true,
                    onPressed: () {},
                    label: '\$15',
                  ),
                  DonationButton(
                      filled: true,
                      onPressed: () {},
                      label: 'Enter a different amount'),
                ],
              ),
            )
          ],
        ),
      ),
      onBtnClick: () {},
      title: 'Continue',
      isBtnDisabled: false,
      logoHeight: 0,
    );
  }
}
