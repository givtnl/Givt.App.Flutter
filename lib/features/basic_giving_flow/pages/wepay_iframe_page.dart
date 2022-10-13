import 'dart:collection';

import 'package:flutter/services.dart';
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
                  android: AndroidInAppWebViewOptions(textZoom: 0),
                  crossPlatform: InAppWebViewOptions(
                      javaScriptEnabled: true, disableVerticalScroll: true),
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
              Tokenize(
                webViewController!,
              )
            },
          )
        ],
      ),
    );
  }

  void ReloadWebView(InAppWebViewController controller) {
    controller.removeJavaScriptHandler(handlerName: handlerName);
  }

  void LoadWebView(InAppWebViewController controller) {
    controller.addJavaScriptHandler(
        handlerName: handlerName,
        callback: (args) => {
              logger.wtf(args),
            });
    controller.loadData(
      data: WepayHtml.body,
    );
  }

  void PostMessageIframeLoaded(InAppWebViewController controller) {}
  void Tokenize(InAppWebViewController controller) {
    const String tokenizeJavascript = """
        tokenize();
    """;
    controller.evaluateJavascript(source: tokenizeJavascript);
  }
}

Future<JsBeforeUnloadResponse?> getResponse(request) async {
  logger.i(request);
  return null;
}

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:givt_mobile_apps/core/widgets/buttons/generic_button.dart';
// import 'dart:io';
// import 'package:webview_flutter/webview_flutter.dart';
// import '../../../core/templates/logo_header_template.dart';
// import '../../../core/widgets/buttons/generic_button.dart';

// class WePayPage extends StatefulWidget {
//   WePayPage({super.key});

//   @override
//   State<WePayPage> createState() => _WePayPageState();
// }

// class _WePayPageState extends State<WePayPage> {
//   final Completer<WebViewController> _controller =
//       Completer<WebViewController>();

//   @override
//   void initState() {
//     if (Platform.isAndroid) {
//       WebView.platform = SurfaceAndroidWebView();
//     } else if (Platform.isIOS) {
//       WebView.platform = CupertinoWebView();
//     }
//     ;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         //color: Colors.green,
//         //width: double.infinity,
//         //height: MediaQuery.of(context).size.height * 0.7,
//         child: Column(
//           children: <Widget>[
//             const LogoHeaderTemplate(),
//             SizedBox(
//               width: double.infinity,
//               height: MediaQuery.of(context).size.height * 0.3,
//               child: WebView(
//                 javascriptMode: JavascriptMode.unrestricted,
//                 initialUrl:
//                     'https://givt-debug-api.azurewebsites.net/wepay-flutter.html',
//                 onWebViewCreated: _controller.complete,
//                 onWebResourceError: _controller.completeError,
//                 javascriptChannels: Set.from([
//                   JavascriptChannel(
//                       name: 'Print',
//                       onMessageReceived: (JavascriptMessage message) {
//                         //This is where you receive message from
//                         //javascript code and handle in Flutter/Dart
//                         //like here, the message is just being printed
//                         //in Run/LogCat window of android studio
//                         print(message.message);
//                       })
//                 ]),
//               ),
//             ),
//             GenericButton(
//               text: 'Submit',
//               disabled: false,
//               onClicked: () async {
//                 final controller = await _controller.future;
//                 print(controller);
//                 //         var script = """
//                 //     window.wkVars.messageHandler.postMessage({'event': 'Start tokenizing'})
//                 //     const tokenize = window.wkVars.creditCard.tokenize()
//                 //       .then(function(response) {
//                 //         window.wkVars.messageHandler.postMessage({'token': response.id});
//                 //       })
//                 //       .catch(function(error) {
//                 //         let key = error[0].target[0];
//                 //         window.wkVars.creditCard.setFocus(key);
//                 //         window.wkVars.messageHandler.postMessage({'error': JSON.stringify(error)});
//                 //       });
//                 // """;

//                 var script = """
//                               let creditCard = WePay.createCreditCardIframe(iframe_container_id, options);
//                               Print.postMessage(JSON.stringify(creditCard))
                             
//                             """;
//                 var response =
//                     await controller.runJavascriptReturningResult(script);
//                 print(response);
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
