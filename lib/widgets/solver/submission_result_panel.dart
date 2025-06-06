import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:flutter_highlighter/themes/atelier-cave-dark.dart';
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
    final isAccepted =
        widget.submission.isAccepted != null && widget.submission.isAccepted!;
    final textTitle = isAccepted ? 'Accepted Submission' : 'Wrong Answer';
    final textTitleColor = isAccepted ? Colors.green : Colors.red;

    final textDate = widget.submission.createdAt != null
        ? DateFormat("MMMM d, y h:mm a").format(widget.submission.createdAt!)
        : '';

    final memory = widget.submission.runTime;
    final runTime = widget.submission.memoryUsage;

    final testCount = widget.submission.testCases?.length;
    final testCountPassing = widget.submission.testCases
        ?.where((test) => test.passing == true)
        .length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  textTitle,
                  style: TextStyle(
                    fontSize: 20,
                    color: textTitleColor,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '(${testCountPassing ?? 0}/${testCount ?? 0})',
                  style: const TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ],
            ),
            Text(
              textDate,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              memory != null
                  ? 'Memory Usage: ${memory.toStringAsFixed(2)} MB'
                  : 'Memory Usage: N/A',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              runTime != null
                  ? 'Run Time: ${runTime.toStringAsFixed(2)} ms'
                  : 'Run Time: N/A',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 256.0),
                  child: Column(
                    children: [
                      CodeTheme(
                        data: CodeThemeData(
                          styles:
                              Style.currentTheme(context) == Brightness.light
                                  ? vsTheme
                                  : atelierCaveDarkTheme,
                        ),
                        child: SizedBox(
                          height: 900,
                          width: double.infinity,
                          child: CodeField(
                            textStyle: const TextStyle(
                              height: 1.5,
                              leadingDistribution: TextLeadingDistribution.even,
                            ),
                            controller: _controller,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
