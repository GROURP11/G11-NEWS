import 'package:flutter/material.dart';
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LocalNews extends StatelessWidget {
  const LocalNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: WebView(
        initialUrl: "https://www.newvision.co.ug/",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    ));
  }
}
