import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/templates/base_template.dart';
import 'package:provider/provider.dart';

class QRmockPage extends StatelessWidget {
  const QRmockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
      pageContent: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Scan the QR code',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1?.color,
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
      // define this function somewhere else that would contain
      onBtnClick: () => Navigator.pushNamed(context, '/'),
      title: 'Donate',
      isBtnDisabled: false,
      logoHeight: 50,
    );
  }
}
