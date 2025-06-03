import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';

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
            Text('Submission ID: ${widget.submission.id}',
                style: const TextStyle(fontSize: 20)),
            const Text('Accepted Submissions', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
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
    );
  }

  @override
  void didUpdateWidget(covariant SubmissionPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.submission.body != oldWidget.submission.body) {
      _initializeController(); // Update the controller with the new submission body
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    _controller = widget.submission.body != null
        ? CodeController(
            text: widget.submission.body!,
          )
        : CodeController();
  }
}
