// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui_web' as ui;

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
  IFrameElement webView = IFrameElement();

  @override
  Widget build(BuildContext context) {
    final problem = Provider.of<ProblemProvider>(context).focusedProblem;
    ui.platformViewRegistry.registerViewFactory('index', (int viewId) {
      webView = IFrameElement()
        ..src = 'assets/index.html'
        ..style.border = 'none';
      print('registered');
      window.onMessage.listen((message) {
        setState(() {
          result = message.data;
        });
      });

      return webView;
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
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(result),
          SizedBox(
            width: 100,
            height: 10,
            child: HtmlElementView(
              viewType: 'index',
              onPlatformViewCreated: (int id) {
                window.onMessage.listen((message) {
                  setState(() {
                    result = message.data;
                  });
                });
                debugPrint('viewNum: $id');
              },
            ),
          ),
        ],
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
  void dispose() {
    webView.contentWindow!.close();
    super.dispose();
  }

  onRun(code) {
    print('sososo $webView.contentWindow');
    webView.contentWindow?.postMessage(code, '*');
  }
}
