import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/templates/base_template.dart';
import 'package:givt_mobile_apps/core/widgets/buttons/bypass_button.dart';

class CameraPermissionsCheck extends StatelessWidget {
  /// isPermanent not currently useful since we wont
  /// be changing the state if the user decide to refuse
  // final bool isPermanent;
  final VoidCallback onPressed;

  const CameraPermissionsCheck({
    //required this.isPermanent,
    required this.onPressed,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
      pageContent: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Allow Givt to access your camera so you can scan QR codes.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1?.color,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              'Only enabled while you use the app.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText2?.color,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Image.asset('assets/images/camera.png'),
            ),
          ],
        ),
      ),
      bypassBtn: const BypassBtn(
          title: 'continue using the app without the permission',
          where: '/camera-permission'),
      onBtnClick: () => onPressed(),
      title: 'Enable Location',
      isBtnDisabled: false,
    );
  }
}
