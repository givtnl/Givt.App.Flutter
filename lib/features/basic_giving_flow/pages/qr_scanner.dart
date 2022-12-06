import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/qr_stack.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/status_column.dart';
import 'package:givt_mobile_apps/utils/check_internet_connectivity.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/models/organisation.dart';
import 'package:provider/provider.dart';
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
  Widget status = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('Searching for a QR-code',
            style: TextStyle(fontWeight: FontWeight.bold))
      ]);
  @override
  void initState() {
    final connectivityCheck =
        Provider.of<CheckInternet>(context, listen: false);
    connectivityCheck.initiateRealtimeConnectionSubscribtion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Consumer<CheckInternet>(
        builder: (context, provider, child) {
          return QRStack(
              mobileScanner: _mobileScanner(provider.hasInternet),
              statusInfo: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: status),
              hasInternet: provider.hasInternet);
        },
      ),
    );
  }

  Widget _mobileScanner(bool hasInternet) {
    final organisationProvider =
        Provider.of<Organisation>(context, listen: false);
    return MobileScanner(
        allowDuplicates: false,
        controller: cameraController,
        onDetect: (barcode, args) async {
          if (!hasInternet) {
            setState(() {
              status = StatusColumn(
                textColor: const Color.fromARGB(255, 234, 100, 90),
                lineOne: 'Whoops!',
                lineTwo: 'Looks like you’re not connected to the internet.',
                lineThree: 'Try again when you are connected.',
              );
            });
          } else {
            if (barcode.rawValue == null) {
              setState(() {
                status = StatusColumn(
                  textColor: const Color.fromARGB(255, 234, 100, 90),
                  lineOne:
                      'Alas, this code cannot be used within the Givt app.',
                  lineTwo: 'Please scan a Givt QR code.',
                );
              });
            } else {
              setState(() {
                status = StatusColumn(
                  textColor: Theme.of(context).primaryColor,
                  lineOne: 'Hey! Great that you want to give with a QR code!',
                  lineTwo:
                      'Hold on while we are directing you to the campaign.',
                );
              });
              final organisationHasBeenSet = await organisationProvider
                  .setOrganisationFromScannedCode(barcode.rawValue!);
              if (organisationHasBeenSet) {
                _navigationService
                    .navigateTo(routes.DonationAmountTypicalRoute);
              } else {
                setState(() {
                  status = StatusColumn(
                    textColor: const Color.fromARGB(255, 234, 100, 90),
                    lineOne:
                        'Alas, this code cannot be used within the Givt app.',
                    lineTwo: 'Please scan a Givt QR code.',
                  );
                });
              }
            }
          }
        });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
