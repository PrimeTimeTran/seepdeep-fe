// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:convert';
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
  int? count = 0;
  String code = '';
  String result = '';
  bool passing = false;
  bool submitted = false;
  List<TestRun> testRuns = [];
  late Toaster toaster = Toaster(context);
  IFrameElement webView = IFrameElement();
  late Problem problem = Provider.of<ProblemProvider>(context).focusedProblem;

  @override
  Widget build(BuildContext context) {
    // WIP: Fix multi load trigger not recognizing code input
    //
    setSubscription();
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 5,
            width: 100,
            child: HtmlElementView(
              viewType: 'index',
              onPlatformViewCreated: (int id) {},
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                kToolbarHeight -
                5,
            child: VerticalSplitView(
              left: SolverSidebar(
                  problem: problem, passing: passing, submitted: submitted),
              right: buildRight(),
            ),
          ),
        ],
      ),
    );
  }

  HorizontalSplitView buildRight() {
    return HorizontalSplitView(
      top: Editor(
          onRun: (code) => onRun(code),
          onType: (c) => setState(() => code = c)),
      bottom: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double parentHeight = constraints.maxHeight;
          return buildTestPanel(parentHeight);
        },
      ),
    );
  }

  buildTab(title, casePassing) {
    final color = submitted && testRuns.isEmpty
        ? Colors.grey
        : casePassing
            ? Colors.green
            : Colors.red;
    return SizedBox(
      height: 40,
      width: 75,
      child: Row(
        children: [
          if (submitted) Tab(icon: Icon(Icons.circle, size: 10, color: color)),
          const Gap(5),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      ),
    );
  }

  buildTestCase(idx, TestRun testRun, height) {
    final testCase = problem.testSuite![idx];
    final inputs = testCase['inputs'];
    return SizedBox(
        height: height,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 150,
              width: double.infinity,
              child: ListView.builder(
                itemCount: inputs.length,
                itemBuilder: (BuildContext context, int idx) {
                  final testInput = testCase['inputs'][idx]['value'];
                  return Column(
                    children: [
                      TextFormField(
                        initialValue: '$testInput',
                        decoration: const InputDecoration(
                          labelText: "Input",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
            TextFormField(
              readOnly: true,
              initialValue: testRun.outputActual,
              decoration: const InputDecoration(
                labelText: "Output",
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(25),
            TextFormField(
              readOnly: true,
              initialValue: testRun.outputExpected,
              decoration: const InputDecoration(
                labelText: "Expected",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ));
  }

  buildTestPanel(height) {
    List<Widget> testTabs = [];
    List<Widget> testRunResultViews = [];
    if (testRuns.isNotEmpty) {
      for (var entry in testRuns.asMap().entries) {
        int idx = entry.key;
        final element = entry.value;
        final tab = buildTab('Case $idx', element.passing);
        testTabs.add(tab);
        final view = buildTestRunResultView(idx, element, height);
        testRunResultViews.add(view);
      }
    }
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
          height: height - 55,
          width: double.infinity,
          child: DefaultTabController(
            length: testRuns.isNotEmpty ? testTabs.length : 3,
            animationDuration: Duration.zero,
            child: Scaffold(
              appBar: AppBar(
                flexibleSpace: TabBar(
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  tabs: testRuns.isNotEmpty
                      ? testTabs
                      : [
                          buildTab('Case 1', false),
                          buildTab('Case 2', false),
                          buildTab('Case 3', false),
                        ],
                ),
              ),
              body: TabBarView(
                children: testRuns.isNotEmpty
                    ? testRunResultViews
                    : [
                        const Icon(Icons.directions),
                        const Icon(Icons.directions_transit),
                        const Icon(Icons.directions_bike),
                      ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  SingleChildScrollView buildTestRunResultView(idx, testRun, height) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildTestCase(idx, testRun, height),
          ],
        ),
      ),
    );
  }

  onRun(submission) {
    Glob.loadStart();
    // TODO:
    // 1. Add choose language
    final dto = {
      "lang": 'python',
      "body": submission,
      "name": problem.title,
      "problem": problem.id,
      // "testCases": problem.testSuite,
    };
    postSubmission(dto);
  }

  postSubmission(submission) async {
    // TODO:
    // 1. Add loading status and block submit button
    // 2. Return Submission from backend
    // 3. Update UI with submission results
    try {
      final response = await Api.post('submissions', submission);
      // String url = "http://localhost:3000/api/submissions";
      // final response =
      //     await http.post(Uri.parse(url), body: {'data': submission});
      Glob.logI(response);
    } catch (e) {
      print('Error: $e');

      return [];
    }
  }

  setSubscription() {
    ui.platformViewRegistry.registerViewFactory('index', (int viewId) {
      webView = IFrameElement()
        ..src = 'assets/index.html'
        ..style.border = 'none';
      window.onMessage.listen((msg) {
        Glob.loadDone();
        if (msg.data?.startsWith("onMsg Success:")) {
          passing = true;
        } else {
          passing = false;
        }
        List<dynamic> dataList = jsonDecode(msg.data);
        testRuns = dataList.map((item) => TestRun.fromMap(item)).toList();
        setState(() {
          count = count! + 1;
          result = msg.data;
          passing = passing;
          testRuns = testRuns;
          submitted = true;
        });
      }, onError: (e) {
        Glob.logI(e);
      }, onDone: () {
        Glob.logI('Done');
      });
      return webView;
    }, isVisible: false);
  }
}
