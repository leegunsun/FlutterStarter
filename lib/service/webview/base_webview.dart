import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class BaseWebview extends StatefulWidget {
  final String url;
  const BaseWebview({super.key, required this.url});

  @override
  State<BaseWebview> createState() => _BaseWebviewState();
}

class _BaseWebviewState extends State<BaseWebview> {

  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Platform WebView")),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(widget.url)),
        initialSettings: InAppWebViewSettings(
          javaScriptEnabled: true, // JavaScript 활성화
          supportZoom: true,       // 줌 기능 지원
        ),
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        onLoadStart: (controller, url) {
          setState(() {
            // widget.url = url?.toString() ?? "Loading...";
          });
        },
        onLoadStop: (controller, url) {
          setState(() {
            // this.url = url?.toString() ?? "Finished Loading";
          });
        },
        onProgressChanged: (controller, progress) {
          setState(() {
            // this.progress = progress.toDouble();
          });
        },
      ),
    );
  }
}
