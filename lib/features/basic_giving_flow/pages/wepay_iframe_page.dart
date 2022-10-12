import 'dart:async';

import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/widgets/buttons/generic_button.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/templates/logo_header_template.dart';
import '../../../core/widgets/buttons/generic_button.dart';

class WePayPage extends StatefulWidget {
  WePayPage({super.key});

  @override
  State<WePayPage> createState() => _WePayPageState();
}

class _WePayPageState extends State<WePayPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    } else if (Platform.isIOS) {
      WebView.platform = CupertinoWebView();
    }
    ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //color: Colors.green,
        //width: double.infinity,
        //height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: <Widget>[
            const LogoHeaderTemplate(),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl:
                    'https://givt-debug-api.azurewebsites.net/wepay-flutter.html',
                onWebViewCreated: _controller.complete,
                onWebResourceError: _controller.completeError,
                javascriptChannels: Set.from([
                  JavascriptChannel(
                      name: 'Print',
                      onMessageReceived: (JavascriptMessage message) {
                        //This is where you receive message from
                        //javascript code and handle in Flutter/Dart
                        //like here, the message is just being printed
                        //in Run/LogCat window of android studio
                        print(message.message);
                      })
                ]),
              ),
            ),
            GenericButton(
              text: 'Submit',
              disabled: false,
              onClicked: () async {
                final controller = await _controller.future;
                print(controller);
                //         var script = """
                //     window.wkVars.messageHandler.postMessage({'event': 'Start tokenizing'})
                //     const tokenize = window.wkVars.creditCard.tokenize()
                //       .then(function(response) {
                //         window.wkVars.messageHandler.postMessage({'token': response.id});
                //       })
                //       .catch(function(error) {
                //         let key = error[0].target[0];
                //         window.wkVars.creditCard.setFocus(key);
                //         window.wkVars.messageHandler.postMessage({'error': JSON.stringify(error)});
                //       });
                // """;

                var script = """
                              let creditCard = WePay.createCreditCardIframe(iframe_container_id, options);
                              Print.postMessage(JSON.stringify(creditCard))
                             
                            """;
                var response =
                    await controller.runJavascriptReturningResult(script);
                print(response);
              },
            )
          ],
        ),
      ),
    );
  }
}
