// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'main_app_bar.dart';

class SimpleWebView extends StatefulWidget {
  static const String routeName = '/SimpleWebView';

  final String url;
  final String title;
  final Widget? floatingActionButton;

  const SimpleWebView({
    super.key,
    required this.url,
    this.title = "Digitwhale",
    this.floatingActionButton,
  });

  @override
  _SimpleWebViewState createState() => _SimpleWebViewState();
}

class _SimpleWebViewState extends State<SimpleWebView> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    WebViewPlatform.instance;
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: widget.title, height: 60),
      floatingActionButton: SizedBox(
        height: 48,
        child: widget.floatingActionButton,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
