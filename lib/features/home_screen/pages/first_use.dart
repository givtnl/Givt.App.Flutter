import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:givt_mobile_apps/core/templates/logo_header_template.dart';
import 'package:givt_mobile_apps/core/widgets/buttons/floating_centered.dart';
import 'package:givt_mobile_apps/core/widgets/notifications/no_connection_bar.dart';
import 'package:givt_mobile_apps/models/local_storage.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
import 'package:givt_mobile_apps/services/persistent_state_service.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/route_paths.dart' as routes;
import '../../../services/check_internet_connectivity.dart';
import '../widgets/option_button.dart';

class FirstUsePage extends StatefulWidget {
  const FirstUsePage({super.key});

  @override
  State<FirstUsePage> createState() => _FirstUsePageState();
}

class _FirstUsePageState extends State<FirstUsePage> {
  final NavigationService _navigationService = locator<NavigationService>();
  late final PersistentStateService _persistentStateService =
      locator<PersistentStateService>();

  @override
  void initState() {
    final internetConnectivtyProvider =
        Provider.of<ConnectivityService>(context, listen: false);
    internetConnectivtyProvider.initiateRealtimeConnectionSubscribtion();
    initialization();
    super.initState();
    final PersistentState current =
        _persistentStateService.getPersistentState();
    log(
        'They have seen the animation is ${current.welcomed}; and completed one donation is  ${current.completedOneDonation}');
  }

  void initialization() async {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Consumer<ConnectivityService>(
              builder: (context, provider, child) {
                return Stack(
                  children: [
                    child!,
                    (!provider.hasInternet)
                        ? const noConnectionBar()
                        : const SizedBox(),
                  ],
                );
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const LogoHeaderTemplate(),
                      const SizedBox(height: 25),
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Center(
                        child: OptionsButton(
                          title: 'Donate now',
                          subtitle: 'Scan a campaign QR-code',
                          clicked: () {
                            _navigationService.navigateTo(routes.QRScannerPage);
                          },
                          color: Theme.of(context).primaryColor,
                          asset: 'qr_code',
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        'My family',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      const SizedBox(height: 10),
                      TextButton.icon(
                        onPressed: () {
                          _navigationService.navigateTo(routes.ChildCreation);
                        },
                        icon: SvgPicture.asset('assets/svg/add_green.svg'),
                        label: Text(
                          'Add child account',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          floatingActionButton: FloatingCenteredButton(
            asset: 'user',
            clicked: () {
              _navigationService.navigateTo(routes.LoginRoute);
            },
          ),
        ));
  }
}
