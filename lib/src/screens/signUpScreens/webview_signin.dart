import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/api_endpoints.dart';

class WebViewSignIn extends StatefulWidget {
  const WebViewSignIn({super.key});

  @override
  State<WebViewSignIn> createState() => _WebViewSignInState();
}

// ${ApiEndPoints.baseUrl}/auth/google
class _WebViewSignInState extends State<WebViewSignIn> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.disabled)
    ..loadRequest(Uri.parse('${ApiEndPoints.baseUrl}/auth/google'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(controller: controller),
    );
  }
}
