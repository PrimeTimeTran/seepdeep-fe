import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:flutter_highlighter/themes/atelier-cave-dark.dart';
import 'package:highlight/languages/python.dart';

class SubmissionPanel extends StatefulWidget {
  Submission submission;
  SubmissionPanel({
    super.key,
    required this.submission,
  });

  @override
  State<SubmissionPanel> createState() => SubmissionPanelState();
}

class SubmissionPanelState extends State<SubmissionPanel> {
  late CodeController _controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.submission.isAccepted != null &&
                      widget.submission.isAccepted!
                  ? 'Accepted Submission'
                  : 'Wrong Answer',
              style: TextStyle(
                fontSize: 20,
                color: widget.submission.isAccepted != null &&
                        widget.submission.isAccepted!
                    ? Colors.green
                    : Colors.red,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: CodeTheme(
                  data: CodeThemeData(
                    styles: Style.currentTheme(context) == Brightness.light
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant SubmissionPanel oldWidget) {
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
      language: python,
      text: widget.submission.body!,
    );
  }
}
