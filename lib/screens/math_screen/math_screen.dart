// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui_web' as ui;

import 'package:app/global.dart';
import 'package:flutter/material.dart';

class MathScreen extends StatefulWidget {
  const MathScreen({super.key});

  @override
  State<MathScreen> createState() => _MathScreenState();
}

class _MathScreenState extends State<MathScreen> {
  IFrameElement webView = IFrameElement();
  @override
  Widget build(BuildContext context) {
    setSubscription();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 1000,
          width: 1000,
          child: HtmlElementView(
            viewType: 'index',
            onPlatformViewCreated: (int id) {},
          ),
        ),
      ],
    );
  }

  setSubscription() {
    ui.platformViewRegistry.registerViewFactory('index', (int viewId) {
      webView = IFrameElement()
        ..src = 'assets/index.html'
        ..style.border = 'none';
      window.onMessage.listen((msg) {
        print('Hi!');
        if (msg.data?.startsWith("onMsg Success:")) {
        } else {}
      }, onError: (e) {
        Glob.logI(e);
      }, onDone: () {
        Glob.logI('Done');
      });
      return webView;
    }, isVisible: false);
  }
}
