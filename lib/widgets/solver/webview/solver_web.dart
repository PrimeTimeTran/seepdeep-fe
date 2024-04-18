// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui_web' as ui;

import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

class Solver extends StatefulWidget {
  const Solver({super.key});

  @override
  State<Solver> createState() => _SolverState();
}

class _SolverState extends State<Solver> {
  bool? passed;
  String code = '';
  String result = '';
  late Toaster toaster;
  bool submitted = false;
  bool registered = false;
  IFrameElement webView = IFrameElement();

  // Switch to submission
  // {
  //   code:  'print("gogogo")',
  //   lang:  'python',
  // }

  @override
  Widget build(BuildContext context) {
    toaster = Toaster(context);
    print('Building: registered $registered');
    final problem = Provider.of<ProblemProvider>(context).focusedProblem;

    // WIP: Fix multi load trigger not recognizing code input
    //
    if (!registered) {
      ui.platformViewRegistry.registerViewFactory('index', (int viewId) {
        print('Registering');
        webView = IFrameElement()
          ..src = 'assets/index.html'
          ..style.border = 'none';
        window.onMessage.listen((msg) {
          print('onMsg ${msg.data}');

          if (msg.data.startsWith("onMsg Success:")) {
            passed = true;
          } else {
            passed = false;
          }
          toaster.simpleToast(msg.data);
          setState(() {
            result = msg.data;
          });
        });
        return webView;
      });
      setState(() {
        registered = true;
      });
    }

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    kToolbarHeight,
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

  HorizontalSplitView buildRight(problem) {
    return HorizontalSplitView(
      top: Editor(
          onRun: (code) => onRun(code),
          onType: (c) => setState(() => code = c)),
      bottom: buildTestPanel(problem),
    );
  }

  buildTab(title, casePassing) {
    final color = casePassing ? Colors.green : Colors.red;
    return SizedBox(
      height: 40,
      width: 75,
      child: Row(
        children: [
          if (passed != null)
            Tab(icon: Icon(Icons.circle, size: 10, color: color)),
          const Gap(5),
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
    final inputs = testCase['input'];
    return SizedBox(
      height: 300,
      width: double.infinity,
      // Num of parameters for the problem.
      child: ListView.builder(
        itemCount: inputs.length,
        itemBuilder: (BuildContext context, int idx) {
          final testInput = testCase['input'][idx];
          return Column(
            children: [
              TextFormField(
                initialValue: '$testInput',
                decoration: const InputDecoration(
                  labelText: "Input",
                  border: OutlineInputBorder(),
                  hintText: 'Enter a search term',
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }

  buildTestPanel(problem) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    GFButtonBadge(
                      onPressed: () {},
                      text: "Test Cases",
                      textColor: Colors.black,
                      position: GFPosition.start,
                      color: Colors.grey.shade100,
                      icon: const Icon(Icons.science_outlined),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Gap(10),
                    GFButtonBadge(
                      text: "Results",
                      onPressed: () {},
                      color: Colors.grey.shade100,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GFButtonBadge(
                  color: Colors.green.shade600,
                  onPressed: () => onRun(code),
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  text: "Run",
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 300,
          width: double.infinity,
          child: DefaultTabController(
            length: 4,
            animationDuration: Duration.zero,
            child: Scaffold(
              appBar: AppBar(
                flexibleSpace: TabBar(
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  tabs: [
                    buildTab('Case 1', true),
                    buildTab('Case 2', false),
                    buildTab('Case 3', false),
                    buildTab('Case 4', true),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          buildTestCase(problem),
                          SelectableText(result),
                          SizedBox(
                            height: 10,
                            width: 100,
                            child: HtmlElementView(
                              viewType: 'index',
                              onPlatformViewCreated: (int id) {
                                debugPrint('New view loaded: viewNum $id');
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
