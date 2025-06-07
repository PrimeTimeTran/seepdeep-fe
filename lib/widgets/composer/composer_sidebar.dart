import 'dart:async';

import 'package:app/all.dart';
import 'package:app/widgets/composer/comment.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/atom-one-dark.dart';
import 'package:flutter_highlighter/themes/atom-one-light.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:markdown/markdown.dart' as md;

// Problem Requirements
// 1. Name
// 2. Prompt/Description
// 3. Examples
// 4. Answer
// 5. Tests

class CodeElementBuilder extends MarkdownElementBuilder {
  getTheme() {
    return MediaQueryData.fromView(WidgetsBinding.instance.window)
                .platformBrightness ==
            Brightness.light
        ? atomOneDarkTheme
        : atomOneLightTheme;
  }

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    String language = 'sql';

    if (element.attributes['class'] != null) {
      String lg = element.attributes['class'] as String;
      language = lg.substring(9);
    }
    return SizedBox(
      width: MediaQueryData.fromView(WidgetsBinding.instance.window).size.width,
      child: HighlightView(
        element.textContent,
        theme: getTheme(),
        language: language,
        textStyle: GoogleFonts.robotoMono(),
      ),
    );
  }
}

// localhost:3000/api/v1/problems/63f1b0c8d2a3e4f5b8c7e4a9
// localhost:3000/api/v1/problems/63f1b0c8d2a3e4f5b8c7e4a9/editorial
// localhost:3000/api/v1/problems/63f1b0c8d2a3e4f5b8c7e4a9/submissions?user=true
// localhost:3000/api/v1/problems/63f1b0c8d2a3e4f5b8c7e4a9/submissions
// localhost:3000/api/v1/problems/63f1b0c8d2a3e4f5b8c7e4a9/testcases
// localhost:3000/api/v1/problems/63f1b0c8d2a3e4f5b8c7e4a9/testcases/63f1b0c8d2a3e4f5b8c7e4a9
// localhost:3000/api/v1/problems/63f1b0c8d2a3e4f5b8c7e4a9/testcases/63f1b0c8d2a3e4f5b8c7e4a9/submissions
// localhost:3000/api/v1/problems/63f1b0c8d2a3e4f5b8c7e4a9/testcases/63f1b0c8d2a3e4f5b8c7e4a9/submissions?user=true
// localhost:3000/api/v1/problems/63f1b0c8d2a3e4f5b8c7e4a9/testcases/63f1b0c8d2a3e4f5b8c7e4a9/submissions?user=true&problem=63f1b0c8d2a3e4f5b8c7e4a9
// localhost:3000/api/v1/problems/63f1b0c8d2a3e4f5b8c7e4a9/testcases/63f1b0c8d2a3e4f5b8c7e4a9/submissions?user=true&problem=63f1b0c8d2a3e4f5b8c7e4a9&testcase=63f1b0c8d2a3e4f5b8c7e4a9
// localhost:3000/api/v1/problems/63f1b0c8d2a3e4f5b8c7e4a9/testcases/63f1b0c8d2a3e4f5b8c7e4a9/submissions?user=true&problem=63f1b0c8d2a3e4f5b8c7e4a9&testcase=63f1b0c8d2a3e4f5b8c7e4a9&submission=63f1b0c8d2a3e4f5b8c7e4a9

// ignore: must_be_immutable
class ComposerSidebar extends StatefulWidget {
  bool passing;
  bool submitted;
  Problem problem;
  List<TestCase> testCases;
  List<Submission> submissions;
  final Stream<Submission> submissionStream;
  final Function onSelectSubmission;
  ComposerSidebar({
    super.key,
    required this.problem,
    required this.passing,
    required this.submitted,
    required this.testCases,
    required this.submissions,
    required this.submissionStream,
    required this.onSelectSubmission,
  });

  @override
  State<ComposerSidebar> createState() => _ComposerSidebarState();
}

class _ComposerSidebarState extends State<ComposerSidebar> {
  ScrollController controller = ScrollController();
  late Future<List<Submission>> _submissionsFuture;
  late StreamSubscription<Submission> _streamSubscription;
  List<String> editorialComments = [];

  List<Submission> _submissions = [];

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: DefaultTabController(
        length: 4,
        key: ValueKey(widget.submitted),
        initialIndex: widget.submitted ? 3 : 0,
        animationDuration: Duration.zero,
        child: Scaffold(
          appBar: buildToolbar(context),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              buildTabProblemDescription(context),
              buildTabEditorial(),
              SolutionsTable(problem: widget.problem),
              SubmissionTable(
                problem: widget.problem,
                submissions: _submissions,
                submissionsFuture: _submissionsFuture,
                onSelectSubmission: widget.onSelectSubmission,
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildTab(title, icon) {
    return Row(
      children: [
        Tab(icon: Icon(icon)),
        Text(title, style: Theme.of(context).textTheme.bodySmall)
      ],
    );
  }

  ScrollConfiguration buildTabEditorial() {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(30),
              Row(
                children: [
                  SelectableText(
                    'Editorial',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const Spacer(),
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      SelectableText('4.53 (15 Votes)'),
                    ],
                  ),
                ],
              ),
              const Gap(30),
              SelectableText(
                widget.problem.title!,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const Gap(30),
              SelectableText(
                widget.problem.editorialBody!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Gap(30),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Type a comment here... (Markdown Supported)',
                ),
              ),
              if (editorialComments.length < 10)
                const SizedBox(
                  height: 200,
                  child: Center(
                    child: Text('Too few comments so far for this editorial.'),
                  ),
                ),
              if (editorialComments.length > 5)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int idx) {
                    return const ui.CommentRow();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  buildTabProblemDescription(BuildContext context) {
    // Add edit problem
    // return MarkdownEditor(body: widget.problem.body!);
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                widget.problem.title!,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const Gap(30),
              SelectableText(
                widget.problem.body!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Gap(30),
              SizedBox(
                height: getHeight(),
                width: double.infinity,
                child: ListView.builder(
                    itemCount: widget.testCases.length,
                    itemBuilder: (
                      BuildContext context,
                      int idx,
                    ) {
                      final testCase = widget.testCases[idx];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Example ${idx + 1}:",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const SizedBox(height: 5),
                          // TODO: Seperate parameters and add names
                          Row(
                            children: [
                              Text(
                                'Input:',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const Gap(10),
                              SelectableText(
                                testCase.input.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                          const Gap(5),
                          Row(
                            children: [
                              Text(
                                'Output:',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const Gap(10),
                              SelectableText(
                                testCase.outExpected.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildToolbar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: TabBar(
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          tabs: [
            buildTab('Description', Icons.notes),
            buildTab('Editorial', Icons.edit_note),
            buildTab('Solutions', Icons.science_outlined),
            buildTab('Submissions', Icons.history),
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  Future<List<Submission>> getSubmissions() async {
    try {
      final response =
          await Api.get('submissions?problem=${widget.problem.id}&user=true');
      List<Submission> submissions = [];
      for (var submission in response) {
        submissions.add(Submission.fromJson(submission));
      }
      setState(() {
        _submissions = submissions;
      });
      return submissions;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    _submissionsFuture = getSubmissions();
    _streamSubscription = widget.submissionStream.listen((submission) {
      _submissions.insert(0, submission);
      setState(() {
        _submissions = _submissions;
      });
    });
  }
}
