// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  late IFrameElement _vieww;

  @override
  Widget build(BuildContext context) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('index', (int viewId) {
      _vieww = IFrameElement()
        ..src = 'assets/index.html'
        ..style.border = 'none';
      window.onMessage.listen((message) {
        print('Message from HTML: ${message.data}');
      });

      if (_vieww.contentWindow != null) {
        _vieww.contentWindow?.postMessage('sososo', '*');
      }

      return _vieww;
    });
    var go = Container(
      color: Colors.red,
      height: 600,
      width: 600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              onclick();
              // _vieww.contentWindow!.postMessage('Hello from Flutter!', '*');
            },
            child: const Text('Send Message to HTML'),
          ),
          const SizedBox(height: 20),
          const Expanded(
            child: HtmlElementView(
              viewType: 'index',
            ),
          ),
        ],
      ),
    );
    return go;
  }

  onclick() {
    print(_vieww);
    _vieww.contentWindow?.postMessage('print("Loi so sexy")', '*');
  }
}
