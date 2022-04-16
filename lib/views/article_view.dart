import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
//import 'package:webview_flutter_android/src/android_webview.pigeon.dart';

class ArticleView extends StatefulWidget {
  final String? blogUrl;
  //ArticleView({this.blogUrl, String? imageUrl});
  ArticleView({@required this.blogUrl, String? imageUrl});
  //const ArticleView({Key? key}) : super(key: key);

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("G11 ", style: TextStyle(color: Colors.blueGrey)),
            Text(
              "NEWS",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.save)),
          )
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
        child: WebView(
          initialUrl: widget.blogUrl,
          //javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _completer.complete(webViewController);
          },
        ),
      ),
    );
  }
}
