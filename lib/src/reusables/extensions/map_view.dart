import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapWidget extends StatefulWidget {
  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  String url(apiKey) =>
      "https://www.google.com/maps/place/Eiffel+Tower/@48.8584,2.2945,15z";
  final String apiKey = "AIzaSyAOVYRIgupAurZup5y1PRh8Ismb1A3lLao";

  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    WebViewPlatform.instance;
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(url(apiKey)));
  }

  // from Google Cloud Console
  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
