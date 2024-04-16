// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui' as ui;

import 'package:app/screens/code_editor/code_editor_screen.dart';
import 'package:flutter/material.dart';

class Python extends StatefulWidget {
  const Python({super.key});

  @override
  State<Python> createState() => _PythonState();
}

class _PythonState extends State<Python> {
  late IFrameElement _vieww;
  late String result = '';

  @override
  Widget build(BuildContext context) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('index', (int viewId) {
      _vieww = IFrameElement()
        ..src = 'assets/index.html'
        ..style.border = 'none';
      window.onMessage.listen((message) {
        // Extracting this to a class method results in the UI not rerendering.
        setState(() {
          result = message.data;
        });
      });

      if (_vieww.contentWindow != null) {
        _vieww.contentWindow?.postMessage('sososo', '*');
      }

      return _vieww;
    });
    return SizedBox(
      height: 600,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CodeEditorScreen(
            selectedLang: 'python',
            onRun: (code) {
              onRun(code);
            },
          ),
          const SizedBox(height: 20),
          buildResult(),
          const Expanded(
            child: HtmlElementView(
              viewType: 'index',
            ),
          ),
        ],
      ),
    );
  }

  buildResult() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Column(
        children: [
          Text(result),
        ],
      ),
    );
  }

  onRun(code) {
    _vieww.contentWindow?.postMessage(code, '*');
  }
}
