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
  String result = '';
  String code = '';
  bool registered = false;
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
    print('Building: registered $registered');
    final problem = Provider.of<ProblemProvider>(context).focusedProblem;

    if (!registered) {
      ui.platformViewRegistry.registerViewFactory('index', (int viewId) {
        print('Registering');
        webView = IFrameElement()
          ..src = 'assets/index.html'
          ..style.border = 'none';
        window.onMessage.listen((message) {
          print('onMessage ${message.data}');
          toaster.simpleToast(message.data);
          setState(() {
            result = message.data;
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

  buildBottom(problem) {
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
                      onPressed: () {},
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      text: "Results",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GFButtonBadge(
                  color: Colors.green.shade300,
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
          width: double.infinity,
          height: 300,
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          buildTestCase(problem),
                          SelectableText(result),
                          SizedBox(
                            width: 100,
                            height: 10,
                            child: HtmlElementView(
                              viewType: 'index',
                              onPlatformViewCreated: (int id) {
                                // window.onMessage.listen((message) {
                                //   setState(() {
                                //     result = message.data;
                                //   });
                                // });
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
      top: Editor(
          onRun: (code) => onRun(code),
          onType: (code) {
            if (code.length > 1) {
              setState(() {
                code = code;
                print(code);
              });
            }
          }
          // selectedLang: Languages.python,
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
    final inputs = testCase['input'];
    return SizedBox(
      height: 300,
      width: double.infinity,
      // For each test case build it's number of inputs.
      child: ListView.builder(
        itemCount: inputs.length,
        itemBuilder: (BuildContext context, int idx) {
          final testInput = testCase['input'][idx];
          return Column(
            children: [
              TextFormField(
                initialValue: '$testInput',
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a search term',
                  labelText: "Input",
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
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
