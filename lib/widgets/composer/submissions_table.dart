// ignore_for_file: must_be_immutable
import 'dart:async';

import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SubmissionRow extends StatefulWidget {
  const SubmissionRow({super.key});

  @override
  State<SubmissionRow> createState() => _SubmissionState();
}

class SubmissionTable extends StatefulWidget {
  Problem problem;
  List<Submission> submissions;
  Future<List<Submission>> submissionsFuture;
  final Function onSelectSubmission;
  SubmissionTable({
    super.key,
    required this.problem,
    required this.submissions,
    required this.submissionsFuture,
    required this.onSelectSubmission,
  });

  @override
  State<SubmissionTable> createState() => _SubmissionTableState();
}

class _SubmissionState extends State<SubmissionRow> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitleTextStyle: const TextStyle(height: 20),
      title: const Row(
        children: [
          Icon(Icons.circle),
          Text('Username'),
          Spacer(),
          Text('DateTime')
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          SizedBox(
            height: 500,
            width: double.infinity,
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    TextButton(
                      style: const ButtonStyle(
                          visualDensity: VisualDensity.compact),
                      onPressed: () {},
                      child: Text('Tag $index',
                          style: const TextStyle(fontSize: 8)),
                    ),
                    const Text('sososo')
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 5),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.abc),
              Text('# Votes'),
              Icon(Icons.remove_red_eye_outlined),
              Text('# Views'),
              Icon(Icons.comment),
              Text('# Comments'),
            ],
          )
        ],
      ),
    );
  }
}

class _SubmissionTableState extends State<SubmissionTable> {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
          child: FutureBuilder<List<Submission>>(
        future: widget.submissionsFuture,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            if (widget.submissions.isEmpty) {
              return const SizedBox(
                height: 200,
                child: Center(
                  child: Text('No Submissions for this problem.'),
                ),
              );
            }
            final sortedSubmissions = [...widget.submissions];
            sortedSubmissions.sort((a, b) => (b.createdAt ?? DateTime.now())
                .compareTo(a.createdAt ?? DateTime.now()));

            List<DataRow> rows = [];
            for (var i = 0; i < sortedSubmissions.length; i++) {
              final submission = sortedSubmissions[i];
              final statusIcon = submission.isAccepted!
                  ? const Icon(Icons.check_circle_outline_outlined,
                      color: Colors.green)
                  : const Icon(Icons.cancel_outlined, color: Colors.red);
              final statusText = submission.isAccepted!
                  ? const Text(
                      'Accepted',
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    )
                  : const Text(
                      'Wrong Answer',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    );
              final status = Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: statusIcon,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      statusText,
                      const SizedBox(height: 4),
                      Text(
                        submission.createdAt != null
                            ? DateFormat("MMMM d, y h:mm a")
                                .format(submission.createdAt!)
                            : '',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              );

              rows.add(
                DataRow(
                  cells: [
                    DataCell(Text('${sortedSubmissions.length - i}')),
                    DataCell(
                      status,
                      onTap: () {
                        widget.onSelectSubmission(submission);
                      },
                    ),
                    DataCell(Text(submission.language.toString())),
                    DataCell(
                      Row(
                        children: [
                          const Icon(Icons.timer, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(submission.runTime.toString()),
                        ],
                      ),
                    ),
                    DataCell(
                      Row(
                        children: [
                          const Icon(Icons.memory,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(submission.memoryUsage!.toStringAsFixed(3)),
                        ],
                      ),
                    ),
                    DataCell(
                      const Text('This is a note'),
                      onTap: () {
                        widget.onSelectSubmission(submission);
                      },
                    ),
                  ],
                ),
              );
            }

            return DataTable(
              columns: const [
                DataColumn(label: Text('#')),
                DataColumn(
                    label: Text('Status'),
                    columnWidth: FractionColumnWidth(0.3)),
                DataColumn(label: Text('Language')),
                DataColumn(label: Text('Runtime')),
                DataColumn(label: Text('Memory')),
                DataColumn(label: Text('Notes')),
              ],
              rows: rows,
            );
          } else if (snapshot.hasError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                ),
              ],
            );
          }
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ],
          );
        },
      )),
    );
  }
}
