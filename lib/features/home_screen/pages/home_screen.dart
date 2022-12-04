import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:givt_mobile_apps/core/templates/logo_header_template.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/buttons/button_square_updt.dart';
import '../../../core/widgets/navigation/appbar_bottom.dart';
import '../../../utils/check_internet_connectivity.dart';
import '../../../core/constants/route_paths.dart' as routes;

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  CheckInternet? _checkInternet;
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    _checkInternet = Provider.of<CheckInternet>(context, listen: false);
    _checkInternet?.checkRealtimeConnection();
    _checkInternet?.checkInitialConnection();
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SquareButtonE(
                        onClick: () {
                          _navigationService.navigateTo(routes.QRScannerPage);
                        },
                        title: "scan Qr Code",
                        iconName: "qr_code",
                        background: Theme.of(context).colorScheme.surface),
                    SquareButtonE(
                        onClick: () => print('non-functional'),
                        title: "collection device",
                        iconName: "connection",
                        background: Theme.of(context).primaryColor),
                    SquareButtonE(
                        onClick: () => print('non-functional'),
                        title: "find location",
                        iconName: "location_small",
                        background: Color(0xffF1BE5A)),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Text(
                'My favorites',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/svg/add.svg'),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'add favorite church or charity',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBarCustom(),
    );
  }
}
