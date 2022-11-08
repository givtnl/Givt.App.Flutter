import 'dart:convert';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/templates/base_template.dart';
import 'package:givt_mobile_apps/models/organisation.dart';
import 'package:provider/provider.dart';
import '../../../services/api_service.dart';
import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

class QRScannerPage extends StatefulWidget {
  QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  Barcode? result;
  MobileScannerController cameraController = MobileScannerController();
  final NavigationService _navigationService = locator<NavigationService>();
  Column status = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('Searching for a QR-code',
            style: TextStyle(fontWeight: FontWeight.bold))
      ]);

  @override
  Widget build(BuildContext context) {
    final organisationProvider =
        Provider.of<Organisation>(context, listen: false);
    return BaseTemplate(
      pageContent: Column(children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: MobileScanner(
              allowDuplicates: false,
              controller: cameraController,
              onDetect: (barcode, args) async {
                if (barcode.rawValue == null) {
                  setState(() {
                    status = Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('This QR-code is not known in Givt.',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 234, 100, 90),
                                  fontWeight: FontWeight.bold)),
                          Text('Please scan another one.',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 234, 100, 90),
                                  fontWeight: FontWeight.bold))
                        ]);
                  });
                } else {
                  setState(() {
                    status = Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('QR-code found!',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold)),
                          Text('We are retrieving organization details.',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold))
                        ]);
                  });
                  final organisationHasBeenSet = await organisationProvider
                      .setOrganisationFromScannedCode(barcode.rawValue!);
                  if (organisationHasBeenSet) {
                    _navigationService
                        .navigateTo(routes.DonationAmountTypicalRoute);
                  } else {
                    setState(() {
                      status = Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('This QR-code is not known in Givt.',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 234, 100, 90),
                                    fontWeight: FontWeight.bold)),
                            Text('Please scan another one.',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 234, 100, 90),
                                    fontWeight: FontWeight.bold))
                          ]);
                    });
                  }
                }
              }),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.2, child: status)
      ]),
      hasFooterButton: false,
      title: '',
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
