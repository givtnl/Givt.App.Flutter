import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/widgets/notifications/snackbar.dart';

import 'donation.dart';
import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';

class InputController {
  final NavigationService navigationService = locator<NavigationService>();
  BuildContext ctx;
  InputController(this.ctx);

  void handleSubmit(inputAmount, mediumId, toggleLoader) async {
    if (inputAmount.isEmpty || double.parse(inputAmount) <= 2) {
      SnackBarNotifyer(ctx)
          .showSnackBarMessage('Cannot donate less than \$2', Colors.red);
      return;
    }
    await DonationController().completeDonation(
        ctx, double.parse(inputAmount), mediumId, toggleLoader);
    DonationController().navigateToPayment();
  }
}
