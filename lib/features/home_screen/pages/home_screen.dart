import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:givt_mobile_apps/core/templates/logo_header_template.dart';
import 'package:givt_mobile_apps/core/widgets/buttons/floating_centered.dart';
import 'package:givt_mobile_apps/core/widgets/navigation/appbar_bottom.dart';
import 'package:givt_mobile_apps/features/home_screen/widgets/child_card.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
import 'package:givt_mobile_apps/services/user_service.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/notifications/no_connection_bar.dart';
import '../../../models/local_storage.dart';
import '../../../services/check_internet_connectivity.dart';
import '../../../core/constants/route_paths.dart' as routes;
import '../../../services/local_child_service.dart';
import '../widgets/option_button.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  final NavigationService _navigationService = locator<NavigationService>();
  final UserService _userService = locator<UserService>();
  final LocalChildUserService _childUserService =
      locator<LocalChildUserService>();

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
    List<ChildUser> childrenList = _childUserService.getAllChildUsers();
    String firstName = _userService.localUserService.getLocalUser().email;
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const LogoHeaderTemplate(),
                const SizedBox(height: 25),
                Text(
                  'Welcome back $firstName',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                const SizedBox(height: 10),
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
                (childrenList.isNotEmpty)
                    ? SizedBox(
                        height: 180,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: childrenList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ChildCard(
                                childInfo: childrenList[index],
                              );
                            }),
                      )
                    : const SizedBox(),
                TextButton.icon(
                  onPressed: () {
                    _navigationService.navigateTo(routes.ChildCreationRoute);
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
        ),
        //Temporarily disabled
        bottomNavigationBar: BottomBarCustom(),
        //Temporary link to sign up/log in
        // floatingActionButton: FloatingCenteredButton(
        //   asset: 'user',
        //   clicked: () {
        //     _navigationService.navigateTo(routes.LoginRoute);
        //   },
        // ),
      ),
    );
  }
}
