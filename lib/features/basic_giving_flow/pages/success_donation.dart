import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:givt_mobile_apps/core/templates/base_template.dart';
import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

class SuccessDonationPage extends StatelessWidget {
  SuccessDonationPage({super.key});

  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
      pageContent: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/svg/success_duotone.svg',
              height: 50,
            ),
            SizedBox(height: 70),
            Text(
              'Thank you for your \$68 donation to the First Church of Atlanta!',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
      // define this function somewhere else that would contain
      onBtnClick: () =>
          _navigationService.navigateTo(routes.DonationAmountTypicalRoute),
      title: 'Go to home screen',
      isBtnDisabled: false,
      logoHeight: 0,
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
