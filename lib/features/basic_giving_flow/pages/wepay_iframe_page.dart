import 'package:givt_mobile_apps/models/html.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:givt_mobile_apps/core/widgets/buttons/generic_button.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(
              height: 150,
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
          GenericButton(
            text: "Hi",
            disabled: false,
            onClicked: () => {
              webViewController?.evaluateJavascript(source: "tokenize();"),
            },
          )
        ],
      ),
    );
  }
}
