import 'package:dateapp/core/utils/toast_utility.dart';
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

  // 허용할 URL 패턴 정의
  final List<String> allowedUrls = [
    "https://m.blog.naver.com/",
    "https://blog.naver.com"
  ];

  bool _isAllowedUrl(String url) {
    return allowedUrls.any((allowedUrl) => url.startsWith(allowedUrl));
  }

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

        },
        onLoadStop: (controller, url) {

        },
        onProgressChanged: (controller, progress) {

        },
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          final String? url = navigationAction.request.url.toString();

          if (url != null && _isAllowedUrl(url)) {
            return NavigationActionPolicy.ALLOW;
          } else {
            // 허용되지 않은 URL은 차단하고 경고 메시지 표시
            ToastManager.showToast('허용되지 않은 URL입니다.');
            return NavigationActionPolicy.CANCEL;
          }
        },
      ),
    );
  }
}
