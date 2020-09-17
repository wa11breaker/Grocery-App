import 'package:flutter/material.dart';
import 'package:grocery/utilities/appStrings.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final bool tac;

  const WebViewScreen({Key key, this.tac = true}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tac ? 'Terms And Conditions' : 'Privacy Policy',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: tac ? termsAndConditions : privacyPolicy,
          javascriptMode: JavascriptMode.unrestricted,
          gestureNavigationEnabled: true,
        ),
      ),
    );
  }
}
