import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/widgets/notifications/snackbar.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/controller/amount_final.dart';

class InputController {
  BuildContext ctx;
  InputController(this.ctx);

  void handleSubmit(inputAmount, mediumId, toggleLoader) {
    if (inputAmount.isEmpty || int.parse(inputAmount) <= 2) {
      SnackBarNotifyer(ctx)
          .showSnackBarMessage('Cannot donate less than \$2', Colors.red);
      return;
    }
    AmountController().createCachedGivtandNavigate(
        ctx, int.parse(inputAmount), mediumId, toggleLoader);
  }
}
