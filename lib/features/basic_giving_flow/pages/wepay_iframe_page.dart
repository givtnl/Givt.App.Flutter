import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:givt_mobile_apps/core/widgets/buttons/generic_button.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/controller/validation_controllers.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/donation_template.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/text_input_field.dart';
import 'package:givt_mobile_apps/models/html.dart';
import 'package:givt_mobile_apps/models/localStorage.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart'
    hide LocalStorage;
import '../controller/donation_controller.dart';

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
  late InAppWebViewController _webViewController;
  late final LocalStorageProxy realmProxy = locator<LocalStorageProxy>();
  final _postFocusNode = FocusNode();
  final _nameController = TextEditingController();
  final _postcodeController = TextEditingController();
  final _form = GlobalKey<FormState>();
  late String _registeredUserId;

  bool isLoading = false;

  @override
  void initState() {
    LocalUser localUser = realmProxy.realm.all<LocalStorage>().first.userData!;
    _registeredUserId = localUser.userId;
  }

  @override
  void dispose() {
    _postFocusNode.dispose();
  }

  void toggleLoader(bool loading) {
    setState(() {
      isLoading = loading;
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
                    controller: _nameController,
                    validator: (value) => nameValidation(value),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_postFocusNode);
                    },
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontSize: 16),
                    decoration: InputDecoration(
                      hintText: 'Cardholder Name',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(fontSize: 16),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 0)),
                    ),
                  ),
                ),
                SizedBox(height: 15),
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
                      initialData:
                          InAppWebViewInitialData(data: WepayHtml.body),
                      onWebViewCreated: (controller) {
                        _webViewController = controller;
                      },
                      onConsoleMessage: (controller, consoleMessage) {
                        Map<String, dynamic> decoded =
                            json.decode(consoleMessage.message);
                        final wepayToken = decoded['id'];

                        DonationController().createMandateAndSubmitDonation(
                            wepayToken,
                            toggleLoader,
                            context,
                            _registeredUserId);
                      },
                    )),
                const SizedBox(height: 20),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyText2,
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              "If you want to know more about how we protect your data, please read about it in our "),
                      TextSpan(
                          text: 'privacy policy.',
                          style: Theme.of(context).textTheme.bodyText2,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('privacy policy.');
                            }),
                    ],
                  ),
                ),
                // Text(
                //   "If you want to know more about how we protect your data, please read about it in our privacy policy. ",
                //   style: Theme.of(context).textTheme.bodyText2,
                //   textAlign: TextAlign.center,
                // ),
                const SizedBox(height: 55),
              ],
            ),
          ),
        ),
        wepay: true,
        button:
            // (!keyboardIsOpen)?
            (isLoading)
                ? const Center(child: CircularProgressIndicator())
                : GenericButton(
                    text: "Donate",
                    disabled: false,
                    onClicked: () => {
                          if (_form.currentState?.validate() == true)
                            {
                              DonationController().initialiseDonationProcess(
                                  context,
                                  _nameController,
                                  '',
                                  _postcodeController,
                                  _webViewController,
                                  toggleLoader)
                            }
                        })
        //  : SizedBox(),
        );
  }
}
