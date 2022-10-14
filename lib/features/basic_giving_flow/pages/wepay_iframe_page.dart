import 'dart:async';
import 'dart:math';

import 'package:givt_mobile_apps/core/widgets/buttons/generic_button.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/donation_template.dart';
import 'package:givt_mobile_apps/models/html.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
  final _amountController = TextEditingController();
  NavigationService _navigationService = locator<NavigationService>();

  bool isLoading = false;

  toggleLoading() {
    setState(() {
      isLoading = true;
      _startTimer();
    });
  }

  void _startTimer() {
    Timer(const Duration(seconds: 2), () {
      _navigationService.navigateTo(routes.DonationSuccessRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DoantionTemplate(
      questionText: "Fill in your credit details",
      content: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                    child: TextField(
                      autofocus: false,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                      decoration: InputDecoration(
                        hintText: 'Card holder name',
                        hintStyle:
                            Theme.of(context).textTheme.bodyText2?.copyWith(
                                  fontSize: 16,
                                ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 0)),
                      ),
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      onSubmitted: (_) {},
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
                    child: TextField(
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
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      onSubmitted: (_) {},
                    )),
              ),
              SizedBox(
                  height: 135,
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
                    },
                    onConsoleMessage: ((controller, consoleMessage) => {
                          logger.i(consoleMessage),
                        }),
                  )),
            ],
          ),
        ),
      ),
      button: (isLoading)
          ? Center(child: CircularProgressIndicator())
          : GenericButton(
              text: "Donate",
              disabled: false,
              onClicked: () => {
                //webViewController?.evaluateJavascript(source: "tokenize();"),
                toggleLoading()
              },
            ),
    );
  }
}
