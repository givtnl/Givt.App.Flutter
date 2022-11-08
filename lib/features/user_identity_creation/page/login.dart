import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:givt_mobile_apps/core/widgets/buttons/generic_button.dart';
import 'package:givt_mobile_apps/features/user_identity_creation/controller/login.dart';
import 'package:givt_mobile_apps/features/user_identity_creation/widgets/scaffold.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
import '../../../utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

class LoginPage extends StatefulWidget {
  final String? passedEmail;
  const LoginPage({this.passedEmail});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final NavigationService _navigationService =
      locator<NavigationService>();
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formValue = {'email': '', 'password': ''};
  bool isLoading = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    FlutterNativeSplash.remove();
  }

  void toggleLoader(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SignUpScaffold(
      signup: false,
      content: Padding(
        padding: const EdgeInsets.fromLTRB(30, 35, 30, 0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.contains('@') == false) {
                    return 'Please enter your email adress';
                  }
                  return null;
                },
                initialValue: widget.passedEmail,
                onSaved: ((newValue) {
                  _formValue['email'] = newValue!;
                }),
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontSize: 16),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.tertiary,
                  hintText: 'Email',
                  hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Theme.of(context).colorScheme.surface),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 7) {
                    return 'Password must be at least 7 characters long';
                  }
                  if (value.contains(RegExp(r'[0-9]')) == false) {
                    return 'Password must contain a digit';
                  }
                  if (value.contains(RegExp(r'[A-Z]')) == false) {
                    return 'Password must contain an upper case character';
                  }
                  if (value.length > 100) {
                    return 'Password cannot contain more than 100 characters';
                  }
                  return null;
                },
                onSaved: ((newValue) {
                  _formValue['password'] = newValue!;
                }),
                obscureText: _obscureText,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontSize: 16),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.tertiary,
                  hintText: 'Password',
                  hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Theme.of(context).colorScheme.surface),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              (isLoading)
                  ? const Center(child: CircularProgressIndicator())
                  : GenericButton(
                      text: 'Log in',
                      disabled: false,
                      onClicked: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState?.save();
                          toggleLoader(true);
                          LoginController().login(
                            context,
                            _formValue['email']!,
                            _formValue['password']!,
                            toggleLoader,
                          );
                        }
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }
}
