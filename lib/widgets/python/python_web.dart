// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui' as ui;

import 'package:app/screens/code_editor/code_editor_screen.dart';
import 'package:app/utils.dart';
import 'package:app/widgets/problem_prompt.dart';
import 'package:app/widgets/vertical_split_view.dart';
import 'package:flutter/material.dart';

class Python extends StatefulWidget {
  const Python({super.key});

  @override
  State<Python> createState() => _PythonState();
}

class _PythonState extends State<Python> {
  String result = '';
  IFrameElement _view = IFrameElement();
  @override
  Widget build(BuildContext context) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('index', (int viewId) {
      _view = IFrameElement()
        ..src = 'assets/index.html'
        ..style.border = 'none';
      window.onMessage.listen((message) {
        setState(() {
          result = message.data;
        });
      });

      if (_view.contentWindow != null) {
        _view.contentWindow?.postMessage('sososo', '*');
      }

      return _view;
    });
    return SizedBox(
      height: getHeight(),
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: getHeight() - 100,
            width: double.infinity,
            child: VerticalSplitView(
              left: const ProblemPrompt(),
              right: CodeEditorScreen(
                selectedLang: 'python',
                onRun: (code) {
                  onRun(code);
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
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
    _view.contentWindow?.postMessage(code, '*');
  }
}
