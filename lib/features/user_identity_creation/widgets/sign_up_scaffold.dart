import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:givt_mobile_apps/core/templates/logo_header_template.dart';
import 'package:givt_mobile_apps/features/user_identity_creation/controller/sign_up.dart';
import '../../../core/widgets/buttons/button_square_updt.dart';
import '../../../core/widgets/navigation/appbar_bottom.dart';

class SignUpScaffold extends StatelessWidget {
  final Widget content;
  final bool signup;

  SignUpScaffold({required this.signup, required this.content});

  final _formKey = GlobalKey<FormState>();

  final Map<String, String> _formValue = {'email': '', 'password': ''};

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                LogoHeaderTemplate(),
                SizedBox(height: 25),
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
                        ? Text(
                            'Sign up to take advantage of all Givt has to offer.')
                        : Text(
                            'Log in to take advantage of all Givt has to offer.'),
                  ],
                ),
                content
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyText2,
              children: <TextSpan>[
                const TextSpan(text: "Already have an acctount? "),
                TextSpan(
                    text: (signup) ? 'Log in' : 'Sign up',
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        (signup) ? print('Log in') : print('Sign up');
                      }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
