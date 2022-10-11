import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/widgets/notifications/snackbar.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/controller/create_cachedGivt.dart';

class InputController {
  BuildContext ctx;
  InputController(this.ctx);

  void handleSubmit(inputAmount, mediumId) {
    if (inputAmount.isEmpty || int.parse(inputAmount) <= 1.5) {
      SnackBarNotifyer(ctx)
          .showSnackBarMessage('Cannot donate less than \$1.5', Colors.red);
      return;
    }
    createCachedGivtandNavigate(int.parse(inputAmount), mediumId);
  }
}
