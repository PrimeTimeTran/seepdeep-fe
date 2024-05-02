// ignore_for_file: must_be_immutable

import 'package:app/all.dart';
import 'package:flutter/material.dart';

class SubmissionRow extends StatefulWidget {
  const SubmissionRow({super.key});

  @override
  State<SubmissionRow> createState() => _SubmissionState();
}

class SubmissionTable extends StatefulWidget {
  List<Submission> submissions;
  SubmissionTable({super.key, required this.submissions});

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
          Container(
            // color: Colors.red,
            child: const Row(
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
            ),
          )
        ],
      ),
    );
  }
}

class _SubmissionTableState extends State<SubmissionTable> {
  @override
  Widget build(BuildContext context) {
    List<DataRow> rows = [];
    for (var submission in widget.submissions) {
      final statusIcon = submission.isAccepted!
          ? const Icon(Icons.check_circle_outline_outlined, color: Colors.green)
          : const Icon(Icons.cancel_outlined, color: Colors.red);
      rows.add(
        DataRow(
          cells: [
            DataCell(statusIcon),
            DataCell(Text(submission.language.toString())),
            DataCell(Text(submission.runTime.toString())),
            DataCell(Text(submission.memoryUsage!.toStringAsFixed(3))),
            const DataCell(Text('This is a note')),
          ],
        ),
      );
    }
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: DataTable(
          columns: const [
            // Define the headers for each column
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Language')),
            DataColumn(label: Text('Runtime')),
            DataColumn(label: Text('Memory')),
            DataColumn(label: Text('Notes')),
          ],
          rows: rows,
        ),
      ),
    );
  }
}
