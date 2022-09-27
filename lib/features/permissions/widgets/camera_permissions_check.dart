import 'package:flutter/material.dart';

import 'package:givt_mobile_apps/core/templates/base_template.dart';
import 'package:givt_mobile_apps/core/theme/theme.dart';
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
                color: AppTheme.theme.textDark,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              'Only enabled while you use the app.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.theme.textSemi,
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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Palette.background,
  //     body: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
  //           child: SvgPicture.asset(
  //             'assets/svg/logo.svg',
  //             height: 22,
  //           ),
  //         ),
  //          Column(
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
  //               child: BarButtonPermissions(
  //                 onPressed: onPressed,
  //                 //isPermanent: isPermanent,
  //                 title: 'Enable Camera',
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(bottom: 5),
  //               child: TextButton(
  //                 onPressed: () {},
  //                 child: Text(
  //                   'continue using the app without the permission',
  //                   style: TextStyle(
  //                     color: Palette.darkBlue,
  //                     fontSize: 13,
  //                     fontWeight: FontWeight.w700,
  //                     decoration: TextDecoration.underline,
  //                     decorationThickness: 1.5,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
