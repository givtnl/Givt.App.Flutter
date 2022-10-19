import 'dart:async';
import 'dart:io';

import 'package:givt_mobile_apps/core/widgets/buttons/generic_button.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/controller/validation_controllers.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/donation_template.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/text_input_field.dart';
import 'package:givt_mobile_apps/models/html.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../controller/user_controller.dart';
import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

const String handlerName = "registrationMessageHandler";
final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 2, // number of method calls to be displayed
        errorMethodCount: 8, // number of method calls if stacktrace is provided
        lineLength: 120, // width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: true // Should each log print contain a timestamp  ),
        ));

class WePayPage extends StatefulWidget {
  const WePayPage({super.key});

  @override
  State<WePayPage> createState() => _WePayPageState();
}

class _WePayPageState extends State<WePayPage> {
  InAppWebViewController? webViewController;
  bool showiFrame = false;
  final _postFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _postcodeController = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool tokenizing = false;

  NavigationService _navigationService = locator<NavigationService>();

  bool isLoading = false;

  @override
  void dispose() {
    _postFocusNode.dispose();
    _lastNameFocusNode.dispose();
  }

  showiFrameState() {
    setState(() {
      showiFrame = true;
    });
  }

  void onSubmit(BuildContext context) async {
    bool? valid = _form.currentState?.validate();
    if (valid == true) {
      final usrController = UserController(context, _firstNameController.text,
          _lastNameController.text, _postcodeController.text);
      setState(() {
        isLoading = true;
      });

      //create temporary user
      final Map<String, dynamic> tempUserMap =
          await usrController.createAndGetTempUser();
      final tempUserID = tempUserMap["userId"];
      if ((tempUserID is HttpException) == false) {
        final registeredUser = usrController.createAndGetRegisteredUser(
            tempUserID, tempUserMap["user"]);
        print(registeredUser);
        setState(() {
          isLoading = false;
          _navigationService.navigateTo(routes.DonationSuccessRoute);
        });
        webViewController!.evaluateJavascript(source: "tokenize();");
      } else {
        print('Error when creating temp user: $tempUserID');
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _startTimer() {
    Timer(const Duration(seconds: 2), () {
      _navigationService.navigateTo(routes.DonationSuccessRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return DoantionTemplate(
      questionText: "Fill in your credit card details",
      content: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextInputField(
                passedWidget: TextFormField(
                  autofocus: false,
                  controller: _firstNameController,
                  validator: (value) => nameValidation(value),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_lastNameFocusNode);
                  },
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'First Name',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontSize: 16),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(width: 0)),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextInputField(
                passedWidget: TextFormField(
                  autofocus: false,
                  focusNode: _lastNameFocusNode,
                  controller: _lastNameController,
                  validator: (value) => nameValidation(value),
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_postFocusNode),
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontSize: 16),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(width: 0)),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextInputField(
                passedWidget: TextFormField(
                  autofocus: false,
                  focusNode: _postFocusNode,
                  controller: _postcodeController,
                  validator: (value) => postCodeValidation(value),
                  onFieldSubmitted: (_) {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Postal Code',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontSize: 16),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(width: 0)),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                  height: 130,
                  child: InAppWebView(
                    initialOptions: InAppWebViewGroupOptions(
                      android: AndroidInAppWebViewOptions(),
                      crossPlatform: InAppWebViewOptions(
                        javaScriptEnabled: true,
                        disableVerticalScroll: true,
                      ),
                    ),
                    // initialUrlRequest: URLRequest(
                    //   url: Uri(
                    //       scheme: "https",
                    //       host: "givt-debug-api.azurewebsites.net",
                    //       path: "/wepay-flutter.html"),
                    // ),
                    initialData: InAppWebViewInitialData(data: WepayHtml.body),
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                      showiFrameState();
                    },
                    onConsoleMessage: ((controller, consoleMessage) {
                      logger.i(consoleMessage);
                      // hmm could i get the token here?
                    }),
                  )),
              // iframe loads so this dissappears fast, but the wepay iframe takes longer
              // (showiFrame) ? SizedBox() : CircularProgressIndicator(),
            ],
          ),
        ),
      ),
      wepay: true,
      button: (!keyboardIsOpen)
          ? (isLoading)
              ? const Center(child: CircularProgressIndicator())
              : GenericButton(
                  text: "Donate",
                  disabled: false,
                  onClicked: () => onSubmit(context),
                )
          : SizedBox(),
    );
  }
}
