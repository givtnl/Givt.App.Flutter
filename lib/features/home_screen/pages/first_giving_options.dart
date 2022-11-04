import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:givt_mobile_apps/core/templates/logo_header_template.dart';
import 'package:givt_mobile_apps/features/home_screen/widgets/option_button.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import '../../../core/widgets/buttons/button_square_updt.dart';
import '../../../core/widgets/navigation/appbar_bottom.dart';
import '../../../core/constants/route_paths.dart' as routes;

class FirstOptionsPage extends StatelessWidget {
  FirstOptionsPage({super.key});

  final NavigationService _navigationService = locator<NavigationService>();

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
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 30 * 2,
                      child: Text(
                        'How would you \n\nlike to give?',
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            ?.copyWith(height: 0.55),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              OptionsButton(
                title: 'Scan a QR-code',
                subtitle: 'A short explanation how to use it',
                clicked: () {
                  _navigationService.navigateTo(routes.QRMockRoute);
                },
                color: Theme.of(context).colorScheme.surface,
                asset: 'qr_code',
              ),
              OptionsButton(
                title: 'Find collection device',
                subtitle: 'A short explanation how to use it',
                clicked: () => print('find collection device is not available'),
                color: Theme.of(context).primaryColor,
                asset: 'connection',
              ),
              OptionsButton(
                title: 'Find location',
                subtitle: 'A short explanation how to use it',
                clicked: () => print('Finding location is unavailable'),
                color: const Color.fromARGB(255, 241, 190, 90),
                asset: 'location',
              ),
              TextButton(
                  onPressed: () => print('find organization from the list'),
                  child: Text(
                    'Or find an organisation in the list',
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        fontSize: 13, decoration: TextDecoration.underline),
                  ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBarCustom(),
    );
  }
}
