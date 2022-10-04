import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/templates/base_template.dart';
import 'package:givt_mobile_apps/features/benefits/controller/usp_controller.dart';
import 'package:givt_mobile_apps/features/benefits/widget/benefit_row.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/progress.dart';

class UspPage extends StatefulWidget {
  const UspPage({super.key});

  @override
  State<UspPage> createState() => _UspPageState();
}

class _UspPageState extends State<UspPage> {
  String where = '/';

  @override
  void initState() {
    OnboardingProgress current = context
        .read<OnboardingProgressModel>()
        .realm
        .all<OnboardingProgress>()
        .first;
    where = checkProgress(current);
  }

  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
      pageContent: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.usp_title,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1?.color,
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 15),
            const UspRow(benefit: 'Giving in the moment'),
            const UspRow(benefit: 'Give to any church or charity'),
            const UspRow(
                benefit:
                    'One tax statement by Givt even if you\'re giving anonymously'),
            const UspRow(benefit: 'See all your donations in one place'),
            const UspRow(benefit: 'Manage recurring donations'),
            const UspRow(benefit: 'Safe and secure giving'),
            const SizedBox(height: 50),
          ],
        ),
      ),
      // define this function somewhere else that would contain
      onBtnClick: () => Navigator.pushReplacementNamed(context, where),
      title: 'Give Now',
      isBtnDisabled: false,
      logoHeight: 50,
    );
  }
}
