import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:flutter_highlighter/themes/atelier-cave-dark.dart';

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

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              textTitle,
              style: TextStyle(
                fontSize: 20,
                color: textTitleColor,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CodeTheme(
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
                  ],
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
