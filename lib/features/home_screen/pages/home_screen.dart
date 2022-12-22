import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:givt_mobile_apps/core/templates/logo_header_template.dart';
import 'package:givt_mobile_apps/core/widgets/buttons/floating_centered.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/buttons/button_square_updt.dart';
import '../../../core/widgets/navigation/appbar_bottom.dart';
import '../../../core/widgets/notifications/no_connection_bar.dart';
import '../../../services/check_internet_connectivity.dart';
import '../../../core/constants/route_paths.dart' as routes;
import '../widgets/option_button.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    final internetConnectivtyProvider =
        Provider.of<ConnectivityService>(context, listen: false);
    internetConnectivtyProvider.initiateRealtimeConnectionSubscribtion();
    initialization();
    super.initState();
  }

  void initialization() async {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Consumer<ConnectivityService>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              child!,
              (!provider.hasInternet) ? noConnectionBar() : const SizedBox(),
            ],
          );
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LogoHeaderTemplate(),
              SizedBox(height: 25),
              Text(
                'Giving in the moment',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(height: 10),
              Center(
                child: OptionsButton(
                  title: 'Donate now',
                  subtitle: 'Scan a campaign QR-code',
                  clicked: () {
                    _navigationService.navigateTo(routes.QRScannerPage);
                  },
                  color: Theme.of(context).colorScheme.surface,
                  asset: 'qr_code',
                ),
              ),
            ],
          ),
        ),
      ),
      //Temporarily disabled
      //bottomNavigationBar: BottomBarCustom(),
      //Temporary link to sign up/log in
      // floatingActionButton: FloatingCenteredButton(
      //   asset: 'user',
      //   clicked: () {
      //     _navigationService.navigateTo(routes.LoginRoute);
      //   },
      // ),
    );
  }
}
