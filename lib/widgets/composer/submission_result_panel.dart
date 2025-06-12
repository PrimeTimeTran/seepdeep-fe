import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:flutter_highlighter/themes/atelier-cave-dark.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class SubmissionResultPanel extends StatefulWidget {
  final Submission submission;
  const SubmissionResultPanel({
    super.key,
    required this.submission,
  });

  @override
  State<SubmissionResultPanel> createState() => SubmissionResultPanelState();
}

class SubmissionResultPanelState extends State<SubmissionResultPanel> {
  late CodeController _controller;

  @override
  Widget build(BuildContext context) {
    final codeThemeStyle = Style.currentTheme(context) == Brightness.light
        ? vsTheme
        : atelierCaveDarkTheme;

    // Calculate the number of lines in the code body
    // and set the height of the editor accordingly.
    final int lineCount =
        '\n'.allMatches(widget.submission.body ?? '').length + 1;
    const double lineHeight = 24.0;
    final double editorHeight = (lineCount * lineHeight).clamp(80.0, 600.0);

    return SafeArea(
      child: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 256.0),
                    child: Card.outlined(
                      child: CodeTheme(
                        data: CodeThemeData(
                          styles: codeThemeStyle,
                        ),
                        child: SizedBox(
                          width: 800,
                          height: 700,
                          child: CodeField(
                            textStyle: const TextStyle(
                              height: 1.5,
                              leadingDistribution: TextLeadingDistribution.even,
                            ),
                            controller: _controller,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildHeader() {
    final isAccepted =
        widget.submission.isAccepted != null && widget.submission.isAccepted!;
    final textTitle = isAccepted ? 'Accepted Submission' : 'Wrong Answer';
    final textTitleColor = isAccepted ? Colors.green : Colors.red;

    final textDate = widget.submission.createdAt != null
        ? 'Submitted on ${DateFormat("MMMM d, y h:mm a").format(widget.submission.createdAt!)}'
        : '';

    final memory = widget.submission.runTime;
    final runTime = widget.submission.memoryUsage;

    final testCount = widget.submission.testCases.length;
    final testCountPassing = widget.submission.testCases
        .where((test) => test.passing == true)
        .length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Summary',
          style: TextStyle(
            fontSize: 26,
          ),
        ),
        const Gap(10),
        Row(
          children: [
            Text(
              textTitle,
              style: TextStyle(
                fontSize: 16,
                color: textTitleColor,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '(${testCountPassing ?? 0}/${testCount ?? 0}) test cases passed',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
        Text(
          textDate,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          memory != null
              ? 'Memory Usage: ${memory.toStringAsFixed(2)} MB'
              : 'Memory Usage: N/A',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          runTime != null
              ? 'Run Time: ${runTime.toStringAsFixed(2)} ms'
              : 'Run Time: N/A',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const Gap(10),
        const Text('Code', style: TextStyle(fontSize: 26)),
        const Gap(10),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  void didUpdateWidget(covariant SubmissionResultPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.submission.body != oldWidget.submission.body) {
      _initializeController();
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    _controller = CodeController(
      language: selectLanguage(Language.fromName(widget.submission.language!)),
      text: widget.submission.body!,
    );
  }
}
