import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_gutenberg/utils/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BookPage extends StatefulWidget {

  String plainUrl;
  BookPage({this.plainUrl});

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {

  final Completer<WebViewController> _completer = Completer<WebViewController>();
  AppWidgets appWidgets = new AppWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: (widget.plainUrl == null) ? Center(child: appWidgets.errorColumn()) :
          WebView(
            initialUrl: widget.plainUrl,
              onWebViewCreated: (WebViewController webViewController){
                _completer.complete(webViewController);}
          )
        ),
      ),
    );
  }
}
