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
  bool processing = false;
  List<Submission> submissions = [];
  List<TestCase> testCases = [];
  late Toaster toaster = Toaster(context);
  late Problem problem = Provider.of<ProblemProvider>(context).focusedProblem;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                kToolbarHeight -
                5,
            child: VerticalSplitView(
              left: SolverSidebar(
                  problem: problem,
                  passing: passing,
                  submitted: submitted,
                  submissions: submissions),
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
                        icon: const Icon(Icons.science_outlined),
                        label: const Text('Test Cases')),
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
                            : const Icon(Icons.keyboard_double_arrow_right),
                        label: const Text('Test Result')),
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildTestCase(idx, testCase, height),
          ],
        ),
      ),
    );
  }

  getSubmissions() async {
    try {
      final response =
          await Api.get('submissions?problem=${problem.id}&user=true');
      for (var submission in response) {
        submissions.add(Submission.fromJson(submission));
      }
      setState(() {
        submissions = submissions;
      });
    } catch (e) {
      print('Error: $e');
      return [];
    } finally {}
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      problem =
          Provider.of<ProblemProvider>(context, listen: false).focusedProblem;
      setupTestCases();
      getSubmissions();
    });
  }

  onRun(submission) {
    // TODO:
    // 1. Add choose language
    final dto = {
      "lang": 'python',
      "body": submission,
      "name": problem.title,
      "problem": problem.id,
    };
    postSubmission(dto);
  }

  // TODO:
  // 1. Add loading status and block submit button
  // 2. Return Submission from backend
  // 3. Update UI with submission results
  postSubmission(item) async {
    try {
      setState(() {
        processing = true;
      });
      final response = await Api.post('submissions', item);
      final submission = Submission.fromJson(response['submission']);
      submissions.insert(0, submission);
      testCases = submission.testCases!;
      setState(() {
        testCases = testCases;
        submissions = submissions;
      });
    } catch (e) {
      print('Error: $e');
      return [];
    } finally {
      setState(() {
        submitted = true;
        processing = false;
      });
    }
  }

  setupTestCases() {
    for (var testCase in problem.testSuite!) {
      testCases.add(TestCase.fromMap({
        "passing": false,
        "input": testCase['input'],
        "signature": problem.signature,
        "outExpected": testCase['output'].toString()
      }));
    }
    setState(() {
      testCases = testCases;
    });
  }
}
