import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class CampaignInfo extends StatelessWidget {
  final String orgName;
  final String orgCause;
  final String orgCauseDescription;
  const CampaignInfo({
    super.key,
    required this.orgCause,
    required this.orgCauseDescription,
    required this.orgName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            orgName,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            orgCause.toUpperCase(),
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ReadMoreText(
            // should be received as an argument
            orgCauseDescription,
            trimLines: 3,
            trimLength: 110,
            trimCollapsedText: ' Read more',
            trimExpandedText: ' Less',
            style: Theme.of(context).textTheme.bodyText2,
            moreStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color.fromARGB(255, 53, 80, 112),
                ),
            lessStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
      ],
    );
  }
}
