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
    return Column(
      children: [
        SizedBox(
          height: getHeight(),
          width: double.infinity,
          child: Container(
            // color: Colors.red,
            child: VerticalSplitView(
              left: const ProblemPrompt(),
              right: buildRight(),
            ),
          ),
        ),
      ],
    );
  }

  buildResult() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 25),
          Text(result),
        ],
      ),
    );
  }

  HorizontalSplitView buildRight() {
    return HorizontalSplitView(
      top: CodeEditorScreen(
        selectedLang: 'python',
        onRun: (code) {
          onRun(code);
        },
      ),
      bottom: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 10),
            buildResult(),
            const Expanded(
              child: HtmlElementView(
                viewType: 'index',
              ),
            ),
          ],
        ),
      ),
    );
  }

  onRun(code) {
    _view.contentWindow?.postMessage(code, '*');
  }
}
