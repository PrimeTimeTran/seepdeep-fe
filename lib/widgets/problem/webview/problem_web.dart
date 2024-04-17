// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui' as ui;

import 'package:app/providers/problem_provider.dart';
import 'package:app/screens/code_editor/code_editor_screen.dart';
import 'package:app/screens/code_editor/setups.dart';
import 'package:app/utils.dart';
import 'package:app/widgets/problem/problem_prompt.dart';
import 'package:app/widgets/vertical_split_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProblemView extends StatefulWidget {
  const ProblemView({super.key});

  @override
  State<ProblemView> createState() => _ProblemViewState();
}

class _ProblemViewState extends State<ProblemView> {
  String result = '';

  IFrameElement _view = IFrameElement();
  @override
  Widget build(BuildContext context) {
    final problem = Provider.of<ProblemProvider>(context).focusedProblem;
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
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: getHeight(),
              width: double.infinity,
              child: VerticalSplitView(
                left: ProblemPrompt(problem: problem!),
                right: buildRight(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildBottom() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(result),
            const HtmlElementView(
              viewType: 'index',
            ),
          ],
        ),
      ),
    );
  }

  HorizontalSplitView buildRight() {
    return HorizontalSplitView(
      top: CodeEditorScreen(
        selectedLang: Languages.python,
        onRun: (code) {
          onRun(code);
        },
      ),
      bottom: buildBottom(),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  onRun(code) {
    _view.contentWindow?.postMessage(code, '*');
  }
}
