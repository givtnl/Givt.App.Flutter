import 'package:flutter/material.dart';
import 'dart:convert';
import '../../../core/templates/base_template.dart';
import '../widgets/email_field.dart';
import '../../../models/user.dart';
import '../controller/registration_controller.dart';

class FirstTimeRegistrationPage extends StatefulWidget {
  const FirstTimeRegistrationPage({super.key});

  @override
  State<FirstTimeRegistrationPage> createState() =>
      _FirstTimeRegistrationPageState();
}

class _FirstTimeRegistrationPageState extends State<FirstTimeRegistrationPage> {
  bool btnClicked = false;
  bool btnDisabled = true;
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

  buttonClicked() {
    btnClicked = true;
    final form = _formKey.currentState;
    FocusManager.instance.primaryFocus?.unfocus();

    if (form != null && form.validate()) {
      final email = _emailController.text;
      final controller = RegistrationController();
      controller
          .checkTLDAndCreateTempUser(email)
          .then((response) => showSnackBarMessage(
              'Temp User created successfully!', Colors.green))
          .catchError(
              (error) => showSnackBarMessage(error.toString(), Colors.red));
    }
  }

  void showSnackBarMessage(String message, Color color) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        backgroundColor: color,
        content: Text(message),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
      pageContent: Padding(
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
      onBtnClick: buttonClicked,
      title: 'Continue',
      isBtnDisabled: btnDisabled,
    );
  }
}
