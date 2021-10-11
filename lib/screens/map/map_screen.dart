import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapScreen extends StatefulWidget {
  static const id = 'map';
  static Route route() => MaterialPageRoute(
        settings: RouteSettings(name: MapScreen.id),
        builder: (context) => MapScreen(),
      );
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final WebViewController _webViewController;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Map', style: TextStyle(fontWeight: FontWeight.w700))),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: 'about:blank',
          onWebViewCreated: (webViewController) {
            _webViewController = webViewController;
            _loadHtmlFromAssets();
          },
        ),
      ),
    );
  }

  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('files/onemap.html');
    _webViewController.loadUrl(Uri.dataFromString(
      fileText,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString());
  }
}
