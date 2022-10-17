import 'dart:async';
import 'dart:io';

import 'package:givt_mobile_apps/core/widgets/buttons/generic_button.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/donation_template.dart';
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
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _postcodeController = TextEditingController();
  final _form = GlobalKey<FormState>();

  NavigationService _navigationService = locator<NavigationService>();

  bool isLoading = false;

  @override
  void dispose() {
    _postFocusNode.dispose();
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
      setState(() async {
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
    return DoantionTemplate(
      questionText: "Fill in your credit card details",
      content: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Theme.of(context).canvasColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      side: BorderSide(
                        width: 1,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        autofocus: false,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                        decoration: InputDecoration(
                          hintText: 'First Name',
                          hintStyle:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    fontSize: 16,
                                  ),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(width: 0)),
                        ),
                        controller: _firstNameController,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_postFocusNode);
                        },
                      ),
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Theme.of(context).canvasColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      side: BorderSide(
                        width: 1,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        autofocus: false,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                        decoration: InputDecoration(
                          hintText: 'Last Name',
                          hintStyle:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    fontSize: 16,
                                  ),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(width: 0)),
                        ),
                        controller: _lastNameController,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_postFocusNode);
                        },
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 15, 8, 8),
                child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Theme.of(context).canvasColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      side: BorderSide(
                        width: 1,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                    child: TextFormField(
                      focusNode: _postFocusNode,
                      autofocus: false,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                      decoration: InputDecoration(
                        hintText: 'Postal code',
                        hintStyle:
                            Theme.of(context).textTheme.bodyText2?.copyWith(
                                  fontSize: 16,
                                ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 0)),
                      ),
                      controller: _postcodeController,
                      validator: (value) {
                        bool isZipValid = false;
                        if (value != null && value.isEmpty) {
                          isZipValid = RegExp(r"/(^\d{5}$)|(^\d{5}-\d{4}$)/",
                                  caseSensitive: false)
                              .hasMatch(value);
                          if (isZipValid) {
                            logger.wtf('success');
                            // yay zip is valid
                            return null;
                          }
                        }
                        logger.wtf('please enter a valid post code');
                        return 'please enter a valid post code';
                      },
                    )),
              ),
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
      button: (isLoading)
          ? const Center(child: CircularProgressIndicator())
          : GenericButton(
              text: "Donate",
              disabled: false,
              onClicked: () => onSubmit(context),
            ),
    );
  }
}
