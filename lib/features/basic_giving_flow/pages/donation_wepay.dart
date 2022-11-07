import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:givt_mobile_apps/core/widgets/buttons/generic_button.dart';
import 'package:givt_mobile_apps/core/templates/donation_template.dart';
import 'package:givt_mobile_apps/models/html.dart';
import 'package:givt_mobile_apps/models/localStorage.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart'
    hide LocalStorage;
import '../controller/donation_wepay.dart';

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
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formValue = {'name': '', 'postalCode': ''};
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

    return DonationTemplate(
        questionText: "Fill in your credit card details",
        content: Padding(
          padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _form,
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.surface,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(7.0)),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: TextFormField(
                        autofocus: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the cardholders\' name';
                          }
                          if (value.length > 30) {
                            return 'Cannot exceed 30 characters';
                          }
                          return null;
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
                              ?.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide.none),
                          errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide.none),
                          focusedErrorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide.none),
                        ),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_postFocusNode);
                        },
                        onSaved: ((newValue) {
                          _formValue['name'] = newValue!;
                        }),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.surface,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(7.0)),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: TextFormField(
                        focusNode: _postFocusNode,
                        autofocus: false,
                        validator: (value) {
                          bool isZipValid = false;
                          if (value != null && value.isEmpty == false) {
                            isZipValid = RegExp(
                                    r"^[a-z0-9][a-z0-9\- ]{0,10}[a-z0-9]$",
                                    caseSensitive: false)
                                .hasMatch(value);
                            if (isZipValid) {
                              // yay zip is valid
                              return null;
                            }
                          }
                          return 'Not a Valid Post Code';
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
                              ?.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide.none),
                          errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide.none),
                          focusedErrorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide.none),
                        ),
                        onFieldSubmitted: (_) {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        onSaved: ((newValue) {
                          _formValue['postalCode'] = newValue!;
                        }),
                      ),
                    ),
                  ],
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
                const SizedBox(height: 40),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyText2,
                    children: <TextSpan>[
                      const TextSpan(
                          text:
                              "If you want to know more about how we protect your data, please read about it in our "),
                      TextSpan(
                          text: 'privacy policy.',
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('redirect to privacy policy');
                            }),
                    ],
                  ),
                ),
                const SizedBox(height: 55),
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
                onClicked: () => {
                      if (_form.currentState?.validate() == true)
                        {
                          _form.currentState?.save(),
                          DonationController().initialiseDonationProcess(
                              context,
                              _formValue,
                              _webViewController,
                              toggleLoader)
                        }
                    }));
  }
}
