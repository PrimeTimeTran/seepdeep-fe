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
import 'package:gap/gap.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

import '../../toasts.dart';

class ProblemView extends StatefulWidget {
  const ProblemView({super.key});

  @override
  State<ProblemView> createState() => _ProblemViewState();
}

class _ProblemViewState extends State<ProblemView> {
  String result = '';
  bool submitted = false;
  IFrameElement webView = IFrameElement();

  // Switch to submission
  // {
  //   code:  'print("gogogo")',
  //   lang:  'python',
  // }
  late Toaster toaster;

  @override
  Widget build(BuildContext context) {
    toaster = Toaster(context);

    final problem = Provider.of<ProblemProvider>(context).focusedProblem;
    ui.platformViewRegistry.registerViewFactory('index', (int viewId) {
      webView = IFrameElement()
        ..src = 'assets/index.html'
        ..style.border = 'none';
      window.onMessage.listen((message) {
        toaster.displayInfoMotionToast(message.data);
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
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: getHeight(),
                width: double.infinity,
                child: VerticalSplitView(
                  left: ProblemPrompt(problem: problem!),
                  right: buildRight(problem),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildBottom(problem) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              GFButtonBadge(
                icon: const Icon(Icons.abc),
                position: GFPosition.start,
                color: Colors.grey.shade100,
                textColor: Colors.black,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
                onPressed: () {},
                text: "Test Cases",
              ),
              const Gap(10),
              GFButtonBadge(
                color: Colors.grey.shade100,
                textColor: Colors.black,
                onPressed: () {},
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
                text: "Results",
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 500,
          child: DefaultTabController(
            length: 4,
            animationDuration: Duration.zero,
            child: Scaffold(
              appBar: AppBar(
                flexibleSpace: TabBar(
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  tabs: [
                    buildTab('Case 1'),
                    buildTab('Case 2'),
                    buildTab('Case 3'),
                    buildTab('Case 4'),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTestCase(problem),
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
                    ),
                  ),
                  const Icon(Icons.directions_transit),
                  const Icon(Icons.directions_bike),
                  const Icon(Icons.directions_boat_rounded),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  HorizontalSplitView buildRight(problem) {
    return HorizontalSplitView(
      top: CodeEditorScreen(
        onRun: (code) => onRun(code),
        selectedLang: Languages.python,
      ),
      bottom: buildBottom(problem),
    );
  }

  buildTab(title) {
    return SizedBox(
      width: 75,
      child: Row(
        children: [
          const Tab(
            icon: Icon(
              Icons.check_box_outlined,
              color: Colors.green,
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      ),
    );
  }

  buildTestCase(problem) {
    final testCase = problem.testSuite![0];
    final input = testCase['input'][0];
    final input2 = testCase['input'][1];
    final output = testCase['output'][0];
    return Column(
      children: [
        TextFormField(
          initialValue: '$input',
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter a search term',
            labelText: "Input",
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          initialValue: '$input2',
          style:
              const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          // Unable to move label outside as of now.
          decoration: const InputDecoration(
            // filled: true,
            // fillColor: Colors.blue,
            // contentPadding: EdgeInsets.all(0),
            // floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
            hintText: 'Enter a search term',
            labelText: "Input 2",
          ),
        ),
        // SelectableText(result),
      ],
    );
  }

  @override
  void dispose() {
    webView.contentWindow!.close();
    super.dispose();
  }

  onRun(submission) {
    setState(() {
      submitted = true;
    });
    webView.contentWindow?.postMessage(submission, '*');
  }
  // onRun(code) {
  //   webView.contentWindow?.postMessage(code, '*');
  // }
}
