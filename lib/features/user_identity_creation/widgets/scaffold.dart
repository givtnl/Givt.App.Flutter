import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:givt_mobile_apps/core/templates/logo_header_template.dart';
import 'package:givt_mobile_apps/features/user_identity_creation/controller/sign_up.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
import 'package:givt_mobile_apps/services/persistent_state_service.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import '../../../core/widgets/buttons/button_square_updt.dart';
import '../../../core/widgets/navigation/appbar_bottom.dart';
import '../../../core/constants/route_paths.dart' as routes;
import '../../../models/local_storage.dart';

class SignUpScaffold extends StatelessWidget {
  final Widget content;
  final bool signup;

  SignUpScaffold({required this.signup, required this.content});
  final NavigationService _navigationService = locator<NavigationService>();
  late final PersistentStateService _persistentStateService =
      locator<PersistentStateService>();
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formValue = {'email': '', 'password': ''};
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final PersistentState state = _persistentStateService.getPersistentState();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const LogoHeaderTemplate(),
                const SizedBox(height: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 30 * 2,
                      child: Text(
                        (signup) ? 'Welcome,' : 'Welcome back,',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    (signup)
                        ? const Text(
                            'Sign up to take advantage of all Givt has to offer.')
                        : const Text(
                            'Log in to take advantage of all Givt has to offer.'),
                  ],
                ),
                content,
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot password?',
                      style: Theme.of(context).textTheme.subtitle2,
                    )),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyText2,
                    children: <TextSpan>[
                      TextSpan(
                          text: (signup)
                              ? 'Already have an account? '
                              : 'Dont have an account yet? '),
                      TextSpan(
                          text: (signup) ? 'Log in' : 'Sign up',
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              (signup)
                                  ? _navigationService
                                      .navigateTo(routes.LoginRoute)
                                  : _navigationService
                                      .navigateTo(routes.SignUpRoute);
                            }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: TextButton(
              onPressed: () {
                _navigationService.navigateTo((state.completedOneDonation)
                    ? routes.HomeScreenRoute
                    : routes.FirstUseScreenRoute);
              },
              child: Text(
                'Continue giving anonymously',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              )),
        ),
      ),
    );
  }
}
