import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/constants/palette.dart';
import 'package:givt_mobile_apps/core/templates/base_template.dart';
import 'package:givt_mobile_apps/core/theme/theme.dart';
import 'package:givt_mobile_apps/features/benefits/widget/benefit_row.dart';

class UspPage extends StatelessWidget {
  const UspPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
      pageContent: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Benefits of Givt',
              style: TextStyle(
                color: AppTheme.theme.textDark,
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
      onBtnClick: () => Navigator.pushNamed(context, '/location-permission'),
      title: 'Give Now',
      isBtnDisabled: false,
      logoHeight: 50,
    );
  }
}
