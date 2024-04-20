import 'package:app/all.dart';
import 'package:app/widgets/solver/comment.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/atom-one-dark.dart';
import 'package:flutter_highlighter/themes/atom-one-light.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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
    String language = '';

    if (element.attributes['class'] != null) {
      String lg = element.attributes['class'] as String;
      language = lg.substring(9);
    }
    return SizedBox(
      width: getWidth(),
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
  Problem problem;
  bool submitted;
  SolverSidebar({
    super.key,
    required this.problem,
    required this.passing,
    required this.submitted,
  });

  @override
  State<SolverSidebar> createState() => _SolverSidebarState();
}

class _SolverSidebarState extends State<SolverSidebar> {
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      key: ValueKey(widget.submitted),
      initialIndex: widget.submitted ? 3 : 1,
      animationDuration: Duration.zero,
      child: Scaffold(
        appBar: AppBar(
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
                    const Tab(
                      icon: Icon(Icons.science_outlined),
                    ),
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              buildTabProblem(context),
              buildTabEditorial(),
              buildTabSolutions(),
              const ui.SubmissionTable(),
            ],
          ),
        ),
      ),
    );
  }

  buildExamples(Problem problem) {
    return ListView.builder(
      itemCount: problem.testSuite!.length,
      itemBuilder: (BuildContext context, int idx) {
        final item = problem.testSuite![idx];
        return Column(children: [
          const SelectableText("Example 1"),
          const SizedBox(height: 10),
          SelectableText(item['input'].toString()),
          const SizedBox(height: 10),
          SelectableText(item['output'].toString()),
        ]);
      },
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
            ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (BuildContext context, int idx) {
                return const ui.Comment();
              },
            )
          ],
        ),
      ),
    );
  }

  ScrollConfiguration buildTabProblem(BuildContext context) {
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
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SelectableText(widget.problem.body!),
              const SizedBox(height: 10),
              const SelectableText("Example 1"),
              const SizedBox(height: 10),
              SelectableText(widget.problem.testSuite![0]['input'].toString()),
              const SizedBox(height: 10),
              SelectableText(widget.problem.testSuite![0]['output'].toString()),
            ],
          ),
        ),
      ),
    );
  }

  ScrollConfiguration buildTabSolutions() {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search',
              ),
            ),
            SizedBox(
              height: 50,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return TextButton(
                      onPressed: () {},
                      child: const Text('Python'),
                    );
                  },
                ),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: 10,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) {
                return const Divider(color: Colors.grey);
              },
              itemBuilder: (BuildContext context, int idx) {
                return const ui.Solution();
              },
            ),
          ],
        ),
      ),
    );
  }
}
