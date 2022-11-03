import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:givt_mobile_apps/core/templates/logo_header_template.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import '../../../core/widgets/buttons/button_square_updt.dart';
import '../../../core/widgets/navigation/appbar_bottom.dart';
import '../../../core/constants/route_paths.dart' as routes;

class FirstUsePage extends StatefulWidget {
  const FirstUsePage({super.key});

  @override
  State<FirstUsePage> createState() => _FirstUsePageState();
}

class _FirstUsePageState extends State<FirstUsePage> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SizedBox(
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
                      style: Theme.of(context).textTheme.headline6?.copyWith(
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
                  onPressed: () =>
                      _navigationService.navigateTo(routes.FirstOptionsRoute),
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
                        style: Theme.of(context).textTheme.headline6?.copyWith(
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
      ),
      bottomNavigationBar: BottomBarCustom(),
    );
  }
}