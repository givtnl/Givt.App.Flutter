import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/widgets/notifications/snackbar.dart';

import 'donation.dart';
import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';

class InputController {
  final NavigationService navigationService = locator<NavigationService>();
  BuildContext ctx;
  InputController(this.ctx);

  void handleSubmit(inputAmount, mediumId, toggleLoader, snackColor) async {
    if (inputAmount.isEmpty || double.parse(inputAmount) < 2) {
      SnackBarNotifyer(ctx)
          .showSnackBarMessage('Cannot donate less than \$2', snackColor);
      return;
    }
    await DonationController().completeDonation(
        ctx, double.parse(inputAmount), mediumId, toggleLoader);
    DonationController().navigateToPayment();
  }
}
