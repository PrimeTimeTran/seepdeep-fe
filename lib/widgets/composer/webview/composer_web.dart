import 'dart:async';

import 'package:app/all.dart';
import 'package:app/widgets/composer/submission_result_panel.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:flutter_highlighter/themes/atelier-cave-dark.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

GlobalKey _one = GlobalKey();
GlobalKey _three = GlobalKey();
GlobalKey _two = GlobalKey();

class Composer extends StatefulWidget {
  final void Function(VoidCallback) provideFabCallback;
  const Composer({super.key, required this.provideFabCallback});

  @override
  State<Composer> createState() => _ComposerState();
}

class _ComposerState extends State<Composer> with TickerProviderStateMixin {
  int? count = 0;
  Problem? problem;
  String code = '';
  String result = '';
  bool passing = false;
  bool submitted = false;
  bool processing = false;
  List<TestCase> testCases = [];
  late TabController tabController;
  List<Submission> submissions = [];
  List<Submission> selectedSubmissions = [];
  final StreamController<Submission> _submissionStreamController =
      StreamController<Submission>();
  Language selectedLang = Language.python;

  @override
  Widget build(BuildContext context) {
    return CodeTheme(
      data: CodeThemeData(
        styles: Style.currentTheme(context) == Brightness.light
            ? vsTheme
            : atelierCaveDarkTheme,
      ),
      child: Consumer<ProblemProvider>(
        builder: (context, problemProvider, _) {
          Problem problem = problemProvider.focusedProblem;
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
                    left: Showcase(
                      key: _one,
                      targetPadding: const EdgeInsets.symmetric(horizontal: 20),
                      tooltipPosition: TooltipPosition.top,
                      description:
                          '1. Carefully read the questions description & example inputs and outputs.',
                      onBarrierClick: () => debugPrint('Barrier clicked'),
                      child: ComposerSidebar(
                        problem: problem,
                        passing: passing,
                        testCases: testCases,
                        submitted: submitted,
                        submissions: submissions,
                        submissionStream: _submissionStreamController.stream,
                        onSelectSubmission: onSelectSubmission,
                      ),
                    ),
                    right: buildRight(problem),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  HorizontalSplitView buildRight(Problem p) {
    return HorizontalSplitView(
      top: Showcase(
        key: _two,
        description:
            '2. Once you\'re ready to give it a shot enter your code in this panel.',
        onBarrierClick: () => debugPrint('Barrier clicked'),
        child: EditorTabs(
          tabController: tabController,
          selectedSubmissions: selectedSubmissions,
          tabTitles: [
            const Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.code,
                    color: Colors.green,
                  ),
                  SizedBox(width: 8),
                  Text('Code'),
                ],
              ),
            ),
            ...selectedSubmissions.map(
              (_) => const Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.access_alarm, color: Colors.blue),
                    SizedBox(width: 8),
                    Text('Submission'),
                  ],
                ),
              ),
            ),
          ],
          tabContents: [
            Editor(
              problem: p,
              key: ValueKey(p),
              onRun: (code, lang) => onRun(code, lang),
              onType: (c, lang) => setState(() {
                code = c;
                selectedLang = lang;
              }),
            ),
            ...selectedSubmissions.map((submission) {
              return SubmissionResultPanel(submission: submission);
            }),
          ],
        ),
      ),
      bottom: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double parentHeight = constraints.maxHeight;
          return buildTestPanel(parentHeight);
        },
      ),
    );
  }

  SizedBox buildTestCase(idx, TestCase testCase, height) {
    final inputEntries = testCase.inputs.entries.toList();
    return SizedBox(
        height: height,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 150,
              width: double.infinity,
              child: ListView.builder(
                itemCount: inputEntries.length,
                itemBuilder: (BuildContext context, int idx) {
                  final key = inputEntries[idx].key;
                  final value = inputEntries[idx].value;
                  return Column(
                    children: [
                      TextFormField(
                        initialValue: '$value',
                        decoration: InputDecoration(
                          labelText: key,
                          border: const OutlineInputBorder(),
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
            if (testCase.stackTrace != null)
              TextFormField(
                readOnly: true,
                initialValue: testCase.stackTrace,
                minLines: 3, // Minimum number of lines to show
                maxLines: null, // Expands as needed
                decoration: const InputDecoration(
                  labelText: "Stack Trace",
                  border: OutlineInputBorder(),
                ),
              ),
          ],
        ));
  }

  SizedBox buildTestCaseTab(title, casePassing) {
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

  Showcase buildTestPanel(height) {
    List<Widget> testCaseTabs = [];
    List<Widget> testCaseViews = [];
    if (testCases.isNotEmpty) {
      for (var entry in testCases.asMap().entries) {
        int idx = entry.key;
        final item = entry.value;
        final tab = buildTestCaseTab('Case $idx', item.passing);
        testCaseTabs.add(tab);
        final view = buildTestRunResultView(idx, item, height);
        testCaseViews.add(view);
      }
    }
    final icon = processing
        ? const SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(),
          )
        : const Icon(Icons.keyboard_double_arrow_right, color: Colors.green);
    return Showcase(
      key: _three,
      description: '3. View the results of your code here.',
      onBarrierClick: () => debugPrint('Barrier clicked'),
      child: GestureDetector(
        onTap: () => debugPrint('menu button clicked'),
        child: Card.outlined(
          child: Column(
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
                                  borderRadius: BorderRadius.all(Radius.zero),
                                ),
                              ),
                              onPressed: () {},
                              icon: const Icon(Icons.science_outlined,
                                  color: Colors.green),
                              label: Text(
                                'Test Cases',
                                style: Theme.of(context).textTheme.bodySmall,
                              )),
                          const Gap(10),
                          TextButton.icon(
                            onPressed: () {},
                            icon: icon,
                            label: Text(
                              'Test Result',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            style: TextButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.zero),
                              ),
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
                        text: processing ? "Processing" : "Run (CMD + ')",
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
                                buildTestCaseTab('Case 1', false),
                                buildTestCaseTab('Case 2', false),
                                buildTestCaseTab('Case 3', false),
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
          ),
        ),
      ),
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

  checkIntroCompleted() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowCaseWidget.of(context).startShowCase([_one, _two, _three]);
    });
  }

  @override
  void dispose() {
    _submissionStreamController.close();
    tabController.dispose();
    super.dispose();
  }

  void initializeProblem() {
    var provider = Provider.of<ProblemProvider>(context, listen: false);
    Future.delayed(Duration.zero, () async {
      problem = await provider.checkUrl();
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
    updateTabController();
    initializeProblem();
    widget.provideFabCallback(checkIntroCompleted);
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
    } else if (l == 'python') {
      l = 'python';
    }
    postSubmission({
      "lang": l,
      "body": submission,
      "name": problem!.title,
      "problem": problem!.id,
    });
  }

  onSelectSubmission(Submission submission) {
    setState(() {
      submitted = true;
      testCases = submission.testCases;
      selectedSubmissions = [submission];
      tabController.dispose();
      updateTabController();
    });
    tabController.animateTo(1);
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
      testCases = submission.testCases;
      setState(() {
        testCases = testCases;
      });
      _submissionStreamController.add(submission);
      if (submission.isAccepted == true) {
        Glob.showSnackSuccess(
          'Submission Accepted!',
        );
      } else {
        Glob.showSnackFailure(
          'Submission Failed! Check your solution & try again!',
        );
      }
    } catch (e) {
      print('Error posting submission: $e');
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
      testCases.add(
        TestCase.fromMap(
          {
            "passing": false,
            "inputs": testCase['inputs'],
            "outExpected": testCase['output'].toString()
          },
        ),
      );
    }
    return testCases;
  }

  void updateTabController() {
    tabController = TabController(
      length: selectedSubmissions.length + 1,
      vsync: this,
    );
    tabController.addListener(() {
      if (tabController.index == 0) {
        initializeProblem();
        setState(() {
          submitted = false;
        });
      }
      if (tabController.index == 1) {
        setState(() {
          submitted = true;
          testCases = selectedSubmissions[0].testCases;
        });
      }
    });
  }
}
