import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class BaseWebview extends StatefulWidget {
  final String url;
  const BaseWebview({super.key, required this.url});

  @override
  State<BaseWebview> createState() => _BaseWebviewState();
}

class _BaseWebviewState extends State<BaseWebview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Platform WebView")),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(widget.url),
        ),
      ),
    );
  }
}
