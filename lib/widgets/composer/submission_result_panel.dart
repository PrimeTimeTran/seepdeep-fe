import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:gap/gap.dart';
import 'package:highlight/languages/markdown.dart';
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
  bool isEditing = false;
  late CodeController _controller;
  late CodeController _controllerExplanation;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isEditing) buildSubmissionAdminPanel(),
              if (!isEditing) buildHeader(),
              if (!isEditing) buildCodePanel(),
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView buildCodePanel() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 256.0),
        child: Card.outlined(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Summary',
              style: TextStyle(
                fontSize: 26,
              ),
            ),
            TextButton.icon(
              icon: const Icon(Icons.public),
              label: const Text('Settings'),
              onPressed: () {
                setState(() {
                  isEditing = !isEditing;
                });
              },
            ),
          ],
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
              '($testCountPassing/$testCount) test cases passed',
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

  buildSubmissionAdminPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
          icon: const Icon(Icons.chevron_left),
          label: const Text('Back to Submission'),
          onPressed: () {
            setState(() {
              isEditing = !isEditing;
            });
          },
        ),
        const Gap(10),
        CodeField(
          textStyle: const TextStyle(
            height: 1.5,
            leadingDistribution: TextLeadingDistribution.even,
          ),
          controller: _controllerExplanation,
        ),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                const Text('Share Solution'),
                Checkbox(
                  value: widget.submission.isShared ?? false,
                  onChanged: (bool? value) {
                    setState(() {
                      widget.submission.isShared = value ?? false;
                    });
                  },
                ),
              ],
            ),
            const Gap(10),
            TextButton.icon(
              icon: const Icon(Icons.save, color: Colors.green),
              label: const Text('Save'),
              onPressed: () {
                onUpdateSubmission();
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  void didUpdateWidget(covariant SubmissionResultPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.submission.body != oldWidget.submission.body) {
      _initializeController();
    }
    if (widget.submission.explanation != oldWidget.submission.explanation) {
      _initializeExplanationController();
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeController();
    _initializeExplanationController();
  }

  onUpdateSubmission() async {
    final body = {
      'id': widget.submission.id,
      'isShared': widget.submission.isShared,
      'explanation': _controllerExplanation.text,
    };
    final resp = await Api.put('submissions/${widget.submission.id}', body);
    print(resp);
    Glob.showSnackSuccess(
      'Submission Saved',
    );
  }

  void _initializeController() {
    _controller = CodeController(
      language: selectLanguage(Language.fromName(widget.submission.language!)),
      text: widget.submission.body!,
    );
  }

  _initializeExplanationController() {
    _controllerExplanation = CodeController(
      language: markdown,
      text: widget.submission.explanation ?? '',
    );
  }
}
