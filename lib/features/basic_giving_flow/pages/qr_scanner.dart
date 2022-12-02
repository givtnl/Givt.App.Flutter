import 'dart:convert';
import 'package:givt_mobile_apps/core/templates/logo_header_template.dart';
import 'package:givt_mobile_apps/core/widgets/navigation/appbar_bottom.dart';
import 'package:givt_mobile_apps/utils/check_internet_connectivity.dart';
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
  CheckInternet? _checkInternet;
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
  void initState() {
    _checkInternet = Provider.of<CheckInternet>(context, listen: false);
    _checkInternet?.checkRealtimeConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final organisationProvider =
        Provider.of<Organisation>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Consumer<CheckInternet>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      LogoHeaderTemplate(),
                      SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: MobileScanner(
                                  allowDuplicates: false,
                                  controller: cameraController,
                                  onDetect: (barcode, args) async {
                                    if (!provider.hasInternet) {
                                      setState(() {
                                        status = Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Text(
                                                  'Cannot scan QR-code without internet.',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 234, 100, 90),
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  'Please try with an active connection.',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 234, 100, 90),
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ]);
                                      });
                                    } else {
                                      if (barcode.rawValue == null) {
                                        setState(() {
                                          status = Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Text(
                                                    'This QR-code is not known in Givt.',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 234, 100, 90),
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text('Please scan another one.',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 234, 100, 90),
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ]);
                                        });
                                      } else {
                                        setState(() {
                                          status = Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('QR-code found!',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    'We are retrieving organization details.',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ]);
                                        });
                                        final organisationHasBeenSet =
                                            await organisationProvider
                                                .setOrganisationFromScannedCode(
                                                    barcode.rawValue!);
                                        if (organisationHasBeenSet) {
                                          _navigationService.navigateTo(routes
                                              .DonationAmountTypicalRoute);
                                        } else {
                                          setState(() {
                                            status = Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Text(
                                                      'This QR-code is not known in Givt.',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              234,
                                                              100,
                                                              90),
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(
                                                      'Please scan another one.',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              234,
                                                              100,
                                                              90),
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ]);
                                          });
                                        }
                                      }
                                    }
                                  }),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: status)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              (!provider.hasInternet)
                  ? Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                        width: double.maxFinite,
                        height: 40,
                        color: Colors.black54,
                        child: const Center(
                          child: Text(
                            'No internet connection, you are now in offline mode.',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
