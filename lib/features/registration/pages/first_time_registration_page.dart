import 'package:flutter/material.dart';
import '../../../core/templates/base_template.dart';
import '../widgets/email_field.dart';
import '../controller/registration_controller.dart';

class FirstTimeRegistrationPage extends StatefulWidget {
  const FirstTimeRegistrationPage({super.key});

  @override
  State<FirstTimeRegistrationPage> createState() =>
      _FirstTimeRegistrationPageState();
}

class _FirstTimeRegistrationPageState extends State<FirstTimeRegistrationPage> {
  bool btnDisabled = true;
  bool _isLoading = false;
  final _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(onListen);
  }

  void onListen() => setState(() {
        final form = _formKey.currentState;
        if (form != null && form.validate()) {
          btnDisabled = false;
        } else {
          btnDisabled = true;
        }
      });

  @override
  void dispose() {
    _emailController.removeListener(onListen);
    _emailController.dispose();
    super.dispose();
  }

  void showLoader(bool loadingState) {
    setState(() {
      _isLoading = loadingState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
      pageContent: _isLoading
          ? Center(
              child: Column(
              children: const [
                CircularProgressIndicator(),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Validating Email...',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Enter your email address to store your donations and receive your tax statement',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1?.color,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              EmailField(controller: _emailController),
                            ],
                          ))),
                ],
              ),
            ),
      onBtnClick: () => RegistrationController(
              btnDisabled, _formKey, _emailController.text, context, showLoader)
          .handleButtonClick(),
      title: 'Continue',
      isBtnDisabled: btnDisabled,
    );
  }
}
