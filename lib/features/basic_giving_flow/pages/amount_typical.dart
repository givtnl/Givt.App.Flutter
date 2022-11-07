import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/widgets/buttons/generic_button.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/controller/amount_final.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/donation_button.dart';
import 'package:givt_mobile_apps/core/templates/donation_template.dart';
import 'package:givt_mobile_apps/models/localStorage.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/route_paths.dart' as routes;
import '../../../models/organisation.dart';

class DoantionAmountTypical extends StatefulWidget {
  DoantionAmountTypical({super.key});

  @override
  State<DoantionAmountTypical> createState() => _DoantionAmountTypicalState();
}

class _DoantionAmountTypicalState extends State<DoantionAmountTypical> {
  final NavigationService _navigationService = locator<NavigationService>();
  final LocalStorageProxy _model = locator<LocalStorageProxy>();

  double donationAmount = 0;
  int selection = -1;
  bool isLoading = false;

  void toggleLoader(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  void selectedTypicalAmount(int index, provider) {
    setState(() {
      if (selection == index) {
        selection = -1;
        donationAmount = 0;
        return;
      }
      selection = index;
      donationAmount = provider.amounts?[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final organisationProvider =
        Provider.of<Organisation>(context, listen: false);
    return DonationTemplate(
      wepay: false,
      questionText: "How much would you like to donate?",
      content: Column(children: [
        DonationButton(
          filled: (selection == 0),
          bold: true,
          onPressed: () => selectedTypicalAmount(0, organisationProvider),
          label:
              '\$${(organisationProvider.amounts!.isNotEmpty) ? organisationProvider.amounts![0] : '0'}',
        ),
        DonationButton(
          filled: (selection == 1),
          bold: true,
          onPressed: () => selectedTypicalAmount(1, organisationProvider),
          label:
              '\$${(organisationProvider.amounts!.isNotEmpty) ? organisationProvider.amounts![1] : '0'}',
        ),
        DonationButton(
          filled: (selection == 2),
          bold: true,
          onPressed: () => selectedTypicalAmount(2, organisationProvider),
          label:
              '\$${(organisationProvider.amounts!.isNotEmpty) ? organisationProvider.amounts![2] : '0'}',
        ),
        DonationButton(
            //filled: otherInput,
            specialColor: Theme.of(context).colorScheme.tertiary,
            onPressed: () =>
                _navigationService.navigateTo(routes.DonationAmountInputRoute),
            label: 'Enter a different amount'),
      ]),
      button: (isLoading)
          ? const Center(child: CircularProgressIndicator())
          : GenericButton(
              text: 'Next',
              disabled: donationAmount > 1.5 ? false : true,
              onClicked: () {
                String decodedMediumId =
                    utf8.decode(base64.decode(organisationProvider.mediumId!));
                AmountController().storeCachedGivt(
                    context, donationAmount, decodedMediumId, toggleLoader);
                AmountController().navigateToPayment();
              }),
    );
  }
}
