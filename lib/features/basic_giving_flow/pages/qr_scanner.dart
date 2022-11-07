import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/templates/base_template.dart';
import 'package:givt_mobile_apps/models/organisation.dart';
import 'package:provider/provider.dart';
import '../../../services/api_service.dart';
import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatefulWidget {
  QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  var status = 'Scanning';
  Barcode? result;
  MobileScannerController cameraController = MobileScannerController();
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
      pageContent: Column(children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: MobileScanner(
              allowDuplicates: false,
              controller: cameraController,
              onDetect: (barcode, args) {
                if (barcode.rawValue == null) {
                  setState(() {
                    status = 'Failed to scan QR Code';
                  });
                } else {
                  setState(() {
                    status =
                        'QR code found! Retrieving organisation details...';
                  });

                  getOrganisationFromScannedCode(barcode.rawValue!);
                }
              }),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Center(
            child: Text('$status'),
          ),
        )
      ]),
      hasFooterButton: false,
      title: '',
    );
  }

  void getOrganisationFromScannedCode(String code) async {
    final organisationProvider =
        Provider.of<Organisation>(context, listen: false);
    try {
      final uri = Uri.parse(code);
      final mediumId = uri.queryParameters['code'];
      final response =
          await APIService().getOrganisationDetailsFromMedium(mediumId!);

      Map<String, dynamic> decoded = json.decode(response);
      organisationProvider.organisationDetails(decoded);
      organisationProvider.setMediumId(mediumId);
      _navigationService.navigateTo(routes.DonationAmountTypicalRoute);
    } catch (error) {
      setState(() {
        status = 'Failed to retrieve organisation details';
      });
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
