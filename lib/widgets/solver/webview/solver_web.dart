import 'dart:async';

import 'package:app/all.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
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
  Problem? problem;
  String code = '';
  String result = '';
  bool passing = false;
  bool submitted = false;
  bool processing = false;
  List<TestCase> testCases = [];
  List<Submission> submissions = [];
  final StreamController<Submission> _submissionStreamController =
      StreamController<Submission>();
  Language selectedLang = Language.python;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProblemProvider>(
      builder: (context, problemProvider, _) {
        var problem = problemProvider.focusedProblem;
        return AppHead(
          title: problem.title!,
          description: problem.body!,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    kToolbarHeight,
                child: VerticalSplitView(
                  left: SolverSidebar(
                    problem: problem,
                    passing: passing,
                    testCases: testCases,
                    submitted: submitted,
                    submissions: submissions,
                    submissionStream: _submissionStreamController.stream,
                  ),
                  right: buildRight(problem),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // TODO: Add bg color change when slider is hovered
  buildRight(Problem p) {
    return HorizontalSplitView(
      top: Editor(
        problem: p,
        key: ValueKey(p),
        onRun: (code, lang) => onRun(code, lang),
        onType: (c, lang) => setState(() {
          code = c;
          selectedLang = lang;
        }),
      ),
      bottom: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double parentHeight = constraints.maxHeight;
          return buildTestPanel(parentHeight);
        },
      ),
    );
  }

  buildTab(title, casePassing) {
    final color = submitted && testCases.isEmpty
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

  buildTestCase(idx, TestCase testCase, height) {
    final inputs = testCase.input;
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
                  final input = inputs[idx];
                  return Column(
                    children: [
                      TextFormField(
                        initialValue: '$input',
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
              initialValue: testCase.outExpected,
              decoration: const InputDecoration(
                labelText: "Output",
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(25),
            if (testCase.outActual != 'null')
              TextFormField(
                readOnly: true,
                initialValue: testCase.outActual,
                decoration: const InputDecoration(
                  labelText: "Actual",
                  border: OutlineInputBorder(),
                ),
              ),
          ],
        ));
  }

  buildTestPanel(height) {
    List<Widget> testCaseTabs = [];
    List<Widget> testCaseViews = [];
    if (testCases.isNotEmpty) {
      for (var entry in testCases.asMap().entries) {
        int idx = entry.key;
        final item = entry.value;
        final tab = buildTab('Case $idx', item.passing);
        testCaseTabs.add(tab);
        final view = buildTestRunResultView(idx, item, height);
        testCaseViews.add(view);
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
                    TextButton.icon(
                        style: TextButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.zero))),
                        onPressed: () {},
                        icon: const Icon(Icons.science_outlined,
                            color: Colors.green),
                        label: Text(
                          'Test Cases',
                          style: Theme.of(context).textTheme.bodySmall,
                        )),
                    const Gap(10),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.zero))),
                      onPressed: () {},
                      icon: processing
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator())
                          : const Icon(Icons.keyboard_double_arrow_right,
                              color: Colors.green),
                      label: Text(
                        'Test Result',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: GFButtonBadge(
                  color: Colors.green.shade600,
                  onPressed:
                      processing ? null : () => onRun(code, selectedLang),
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  text: processing ? "Processing" : "Run",
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: DefaultTabController(
            length: testCases.isNotEmpty ? testCaseTabs.length : 3,
            animationDuration: Duration.zero,
            child: Scaffold(
              appBar: AppBar(
                flexibleSpace: TabBar(
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  tabs: testCases.isNotEmpty
                      ? testCaseTabs
                      : [
                          buildTab('Case 1', false),
                          buildTab('Case 2', false),
                          buildTab('Case 3', false),
                        ],
                ),
              ),
              body: TabBarView(
                children: testCases.isNotEmpty
                    ? testCaseViews
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

  SingleChildScrollView buildTestRunResultView(idx, testCase, height) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildTestCase(idx, testCase, height),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _submissionStreamController.close();
    super.dispose();
  }

  void initializeProblem() {
    var provider = Provider.of<ProblemProvider>(context, listen: false);
    Future.delayed(Duration.zero, () async {
      problem = await provider.checkUrl(context);
      testCases = setupTestCases(problem);
      setState(() {
        problem = problem;
        testCases = testCases;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initializeProblem();
  }

  onRun(submission, lang) {
    setState(() {
      selectedLang = lang;
    });
    String l = selectedLanguageName(lang).toLowerCase();
    if (l == 'javascript') {
      l = 'js';
    } else if (l == 'typescript') {
      l = 'ts';
    }
    postSubmission({
      "body": submission,
      "name": problem!.title,
      "problem": problem!.id,
      "lang": l,
    });
  }

  postSubmission(item) async {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: "study_submission_create",
        parameters: {
          "type": "dsa",
          "problem_id": problem?.id,
        },
      );
      setState(() {
        processing = true;
      });
      final response = await Api.post('submissions', item);
      final submission = Submission.fromJson(response['submission']);
      submissions.insert(0, submission);
      testCases = submission.testCases!;
      setState(() {
        testCases = testCases;
      });
      _submissionStreamController.add(submission);
      if (submission.isAccepted == true) {
        Glob.showSnack('Success!');
      }
    } catch (e) {
      print('Error: $e');
      final submission = Submission.placeholder(problem!.id, 1);
      submissions.insert(0, submission);
      testCases = submission.testCases!;
      setState(() {
        testCases = testCases;
      });
    } finally {
      setState(() {
        submitted = true;
        processing = false;
      });
    }
  }

  setupTestCases(problem) {
    testCases = [];
    for (var testCase in problem.testCases) {
      testCases.add(TestCase.fromMap({
        "passing": false,
        "input": testCase['input'],
        "outExpected": testCase['output'].toString()
      }));
    }
    return testCases;
  }
}
