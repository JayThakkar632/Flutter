import 'package:first_flutter_demo_app/common_widget/top_widget.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../router/route_const.dart';

class WebViewDemo extends StatefulWidget {
  const WebViewDemo({super.key});

  @override
  State<WebViewDemo> createState() => _WebViewState();
}

class _WebViewState extends State<WebViewDemo> {

  @override
  Widget build(BuildContext context) {
    late WebViewController webViewController;
    return TopWidget(
        title: 'WebView',
        child: WebView(
            initialUrl: 'https://tan-jaimie-51.tiiny.site',
            javascriptMode:JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController web){
              print("Create");
              webViewController=web;
            },
          javascriptChannels: {JavascriptChannel(name: "Pay", onMessageReceived: (JavascriptMessage message){
            print(message.message);
            var result=context.go(RouteConstant.cameraScreen);
          },)},
        ));
  }
}

