import 'dart:async';

import 'package:app/all.dart';
import 'package:app/widgets/solver/comment.dart' as ui;
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

// ignore: must_be_immutable
class SolverSidebar extends StatefulWidget {
  bool passing;
  bool submitted;
  Problem problem;
  List<TestCase> testCases;
  List<Submission> submissions;
  final Stream<Submission> submissionStream;
  SolverSidebar({
    super.key,
    required this.problem,
    required this.passing,
    required this.submitted,
    required this.testCases,
    required this.submissions,
    required this.submissionStream,
  });

  @override
  State<SolverSidebar> createState() => _SolverSidebarState();
}

class _SolverSidebarState extends State<SolverSidebar> {
  ScrollController controller = ScrollController();
  late Future<List<Submission>> _submissionsFuture;
  late StreamSubscription<Submission> _streamSubscription;
  List<String> editorialComments = [];

  List<Submission> _submissions = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
            // ignore: prefer_const_constructors
            SolutionsTable(problem: widget.problem),
            SubmissionTable(
              problem: widget.problem,
              submissions: _submissions,
              submissionsFuture: _submissionsFuture,
            ),
          ],
        ),
      ),
    );
  }

  ScrollConfiguration buildTabEditorial() {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const SelectableText('Editorial'),
            SelectableText(
              widget.problem.title!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SelectableText(
              widget.problem.editorialBody!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Type a comment here... (Markdown Supported)',
              ),
            ),
            if (editorialComments.length < 10)
              const Text('Too few submissions '),
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
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              SelectableText(
                widget.problem.body!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 400,
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
                            "Example ${idx + 1}",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 5),
                          // TODO: Seperate parameters and add names
                          Row(
                            children: [
                              Text(
                                'Input:',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              const Gap(10),
                              SelectableText(
                                testCase.input.toString(),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                'Output:',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              const Gap(10),
                              SelectableText(
                                testCase.outExpected.toString(),
                                style: Theme.of(context).textTheme.bodyLarge,
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
            Row(
              children: [
                const Tab(
                  icon: Icon(Icons.notes),
                ),
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
            Row(
              children: [
                const Tab(
                  icon: Icon(Icons.edit_note),
                ),
                Text(
                  'Editorial',
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
            Row(
              children: [
                const Tab(icon: Icon(Icons.science_outlined)),
                Text(
                  'Solutions',
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
            Row(
              children: [
                const Tab(
                  icon: Icon(Icons.history),
                ),
                Text(
                  'Submissions',
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
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
    } finally {}
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
