import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/widgets/notifications/no_connection_bar.dart';

import '../../../core/templates/logo_header_template.dart';

class QRStack extends StatelessWidget {
  Widget mobileScanner;
  Widget statusInfo;
  bool hasInternet;
  QRStack(
      {required this.mobileScanner,
      required this.statusInfo,
      required this.hasInternet,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const LogoHeaderTemplate(),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: mobileScanner,
                      ),
                      statusInfo
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        (!hasInternet) ? const noConnectionBar() : const SizedBox(),
      ],
    );
  }
}
