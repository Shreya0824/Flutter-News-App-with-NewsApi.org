import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
final String blogUrl;
ArticleView({required this.blogUrl});
  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {

  final Completer<WebViewController> _completer =Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children:<Widget> [
            Padding(
                padding: EdgeInsets.only(left: 65),
                child: Text("Flutter")),
            Text("News",style: TextStyle(color: Colors.blue),)
          ],
        ),
        elevation: 0.0,
      ),
      body: Container(
        child: WebView(
          initialUrl: widget.blogUrl,
          onWebViewCreated: ((WebViewController webViewController){
_completer.complete(webViewController);
          }
          ),
        ),
      ),
    );
  }
}