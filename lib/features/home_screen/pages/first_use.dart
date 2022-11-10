import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:givt_mobile_apps/core/templates/logo_header_template.dart';
import 'package:givt_mobile_apps/models/localStorage.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
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
  late final LocalStorageProxy storageProxy = locator<LocalStorageProxy>();

  @override
  void initState() {
    _checkInternet = Provider.of<CheckInternet>(context, listen: false);
    _checkInternet?.checkRealtimeConnection();
    initialization();
    super.initState();
    final LocalStorage current = storageProxy.realm.all<LocalStorage>().first;
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: ElevatedButton(
                      onPressed: () => _navigationService
                          .navigateTo(routes.FirstOptionsRoute),
                      style: ElevatedButton.styleFrom(
                        elevation: 7.0,
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 45 * 2,
                        height: 80,
                        child: Center(
                          child: Text(
                            'I want to donate now',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(' ---------- or ---------- ',
                      style: Theme.of(context).textTheme.bodyText1),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 7.0,
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 45 * 2,
                        height: 100,
                        child: Center(
                          child: Text(
                            'I want to select \n\n my favorite organization(s)',
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      color: Colors.white,
                                      height: 0.8,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
      bottomNavigationBar: BottomBarCustom(),
    );
  }
}
