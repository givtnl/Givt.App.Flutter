import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:givt_mobile_apps/core/templates/logo_header_template.dart';
import 'package:givt_mobile_apps/features/home_screen/widgets/option_button.dart';
import 'package:givt_mobile_apps/models/local_storage.dart';
import 'package:givt_mobile_apps/services/local_storage_service.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
import 'package:givt_mobile_apps/services/persistent_state_service.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/navigation/appbar_bottom.dart';
import '../../../core/constants/route_paths.dart' as routes;
import '../../../utils/check_internet_connectivity.dart';

class FirstUsePage extends StatefulWidget {
  const FirstUsePage({super.key});

  @override
  State<FirstUsePage> createState() => _FirstUsePageState();
}

class _FirstUsePageState extends State<FirstUsePage> {
  CheckInternet? _checkInternet;
  final NavigationService _navigationService = locator<NavigationService>();
  late final PersistentStateService _persistentStateService =
      locator<PersistentStateService>();

  @override
  void initState() {
    _checkInternet = Provider.of<CheckInternet>(context, listen: false);
    _checkInternet?.checkRealtimeConnection();
    initialization();
    super.initState();
    final PersistentState current =
        _persistentStateService.getPersistentState();
    print(
        'They have seen the animation is ${current.welcomed}; and completed one donation is  ${current.completedOneDonation}');
  }

  void initialization() async {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Consumer<CheckInternet>(
          builder: (context, provider, child) {
            return Stack(
              children: [
                child!,
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
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  LogoHeaderTemplate(),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 30 * 2,
                          child: Text(
                            'Welcome, ',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                        Text(
                          'choose to start using Givt!',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.surface),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  OptionsButton(
                    title: 'Donate now',
                    subtitle: 'Scan a campaign QR-code',
                    clicked: () {
                      _navigationService.navigateTo(routes.QRScannerPage);
                    },
                    color: Theme.of(context).colorScheme.surface,
                    asset: 'qr_code',
                  ),
                ],
              ),
            ),
          )),
      //Temporarily disabled
      //bottomNavigationBar: BottomBarCustom(),
    );
  }
}
