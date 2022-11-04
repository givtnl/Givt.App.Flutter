import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/widgets/notifications/snackbar.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/controller/amount_final.dart';

import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

class InputController {
  final NavigationService navigationService = locator<NavigationService>();
  BuildContext ctx;
  InputController(this.ctx);

  void handleSubmit(inputAmount, mediumId, toggleLoader) async {
    if (inputAmount.isEmpty || int.parse(inputAmount) <= 2) {
      SnackBarNotifyer(ctx)
          .showSnackBarMessage('Cannot donate less than \$2', Colors.red);
      return;
    }
    await AmountController()
        .storeCachedGivt(ctx, int.parse(inputAmount), mediumId, toggleLoader);
    AmountController().navigateToPayment();
  }
}
